import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/extensions/widgets/chat_bloc/chat_bloc.dart';
import 'package:eliud_pkg_chat/extensions/widgets/chat_bloc/chat_event.dart';
import '../../../tools/chat_helper.dart';
import '../../../tools/room_helper.dart';
import 'all_chats_event.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

import 'package:eliud_pkg_chat/model/room_repository.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'all_chats_state.dart';

class AllChatsBloc extends Bloc<AllChatsEvent, AllChatsState> {
  final RoomRepository _roomRepository;
  StreamSubscription? _roomsListSubscription;
  Map<String, StreamSubscription> chatMemberInfoSubscriptions = {};
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final int roomLimit;
  final String appId;
  final String thisMemberId;
  final ChatBloc chatListBloc;

  void _mapLoadAllChatsWithDetailsToState() async {
    int amountNow = (state is AllChatsLoaded)
        ? (state as AllChatsLoaded).enhancedRoomModels.length
        : 0;
    _roomsListSubscription?.cancel();
    _roomsListSubscription = _roomRepository.listenWithDetails((list) async {
      var enhancedList = await Future.wait(list.map((value) async {
        var otherMemberRoomInfo =
            await RoomHelper.getOtherMembersRoomInfo(thisMemberId, appId, value!.members!);

        listToChatMemberInfoRepository(appId, value.documentID);
        return EnhancedRoomModel(value, null, otherMemberRoomInfo, null);
      }).toList());
      add(AllChatsUpdated(
          value: enhancedList, mightHaveMore: amountNow != list.length));
    },
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * roomLimit : null);
  }

  void listToChatMemberInfoRepository(String appId, String roomId) async {
    var key = appId + "-" + roomId;
    ;
    chatMemberInfoSubscriptions[key]?.cancel();
    chatMemberInfoSubscriptions[key] =
        chatMemberInfoRepository(appId: appId, roomId: roomId)!
            .listenWithDetails((chatMemberInfos) async {
      for (var chatMemberInfo in chatMemberInfos) {
        if (chatMemberInfo!.timestamp != null) {
          add(NewLastReadEvent(appId, roomId, chatMemberInfo.authorId,
              chatMemberInfo.timestamp!));
        }
      }
    },
                eliudQuery: EliudQuery().withCondition(EliudQueryCondition(
                    'readAccess',
                    arrayContains: thisMemberId)));
  }

  Future<void> _mapAddAllChatsToState(AddAllChats event) async {
    var value = event.value;
    if (value != null) await _roomRepository.add(value);
  }

  Future<void> _mapUpdateAllChatsToState(UpdateAllChats event) async {
    var value = event.value;
    if (value != null) await _roomRepository.update(value);
  }

  Future<void> _mapDeleteAllChatsToState(DeleteAllChats event) async {
    var value = event.value;
    if (value != null) await _roomRepository.delete(value);
  }

  AllChatsState _mapAllChatsUpdatedToState(
      AllChatsUpdated event, RoomModel? currentRoom) {
    return AllChatsLoaded(
        enhancedRoomModels: event.value,
        mightHaveMore: event.mightHaveMore,
        currentRoom: currentRoom);
  }

  AllChatsBloc(
      {required this.thisMemberId,
        required this.appId,
        required this.chatListBloc,
        this.paged,
        this.orderBy,
        this.descending,
        this.eliudQuery,
        required RoomRepository roomRepository,
        this.roomLimit = 5})
      : assert(roomRepository != null),
        _roomRepository = roomRepository,
        super(AllChatsLoading()) {
    on<LoadAllChats>((event, emit) {
      _mapLoadAllChatsWithDetailsToState();
    });

    on<NewPage>((event, emit) {
      pages = pages +
          1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadAllChatsWithDetailsToState();
    });

    on<AddAllChats>((event, emit) {
      _mapAddAllChatsToState(event);
    });

    on<UpdateAllChats>((event, emit) async {
      await _mapUpdateAllChatsToState(event);
    });

    on<DeleteAllChats>((event, emit) async {
      await _mapDeleteAllChatsToState(event);
    });

    on<AllChatsUpdated>((event, emit) async {
      var theState = state;
      var currentRoom = (theState is AllChatsLoaded)
          ? theState.currentRoom
          : ((event.value.isNotEmpty) ? event.value[0].roomModel : null);
      emit(_mapAllChatsUpdatedToState(event, currentRoom));
    });
    on<SelectChat>((event, emit) async {
      var theState = state;
      if (theState is AllChatsLoaded) {
        for (var selectedEnhancedRoom in theState.enhancedRoomModels) {
          if (selectedEnhancedRoom.roomModel.documentID ==
              event.selected.documentID) {
//            chatListBloc.add(SelectChatEvent(selectedEnhancedRoom)); <<<< RECOVER THIS LINE
            chatListBloc.add(OpenChatWithMembersEvent(event.selected.members!));
          }
        }
        emit(AllChatsLoaded(
            enhancedRoomModels: theState.enhancedRoomModels,
            mightHaveMore: theState.mightHaveMore,
            currentRoom: event.selected));
      } else {
        throw Exception("Unexpected state");
      }
    });

    on<NewLastReadEvent>((event, emit) async {
      var theState = state;
      if (theState is AllChatsLoaded) {
        List<EnhancedRoomModel> newEnhancedRoomModels = [];
        for (var enhancedRoomModel in theState.enhancedRoomModels) {
          if (enhancedRoomModel.roomModel.documentID == event.roomId) {
            var newEnhancedModel;
            if (event.memberId == thisMemberId) {
              newEnhancedModel = enhancedRoomModel.copyWith(
                  timeStampThisMemberRead: event.lastRead);
            } else {
              newEnhancedModel = enhancedRoomModel.copyWith(
                  otherMemberLastRead: event.lastRead);
            }
            newEnhancedRoomModels.add(newEnhancedModel);
            chatListBloc.add(UpdateEnhancedRoomModel(newEnhancedModel));
          } else {
            newEnhancedRoomModels.add(enhancedRoomModel);
          }
        }
        emit(AllChatsLoaded(
            mightHaveMore: theState.mightHaveMore,
            currentRoom: theState.currentRoom,
            enhancedRoomModels: newEnhancedRoomModels));
      }
    });
  }

  @override
  Future<void> close() {
    _roomsListSubscription?.cancel();
    for (var chatMemberInfoSubscription in chatMemberInfoSubscriptions.values) {
      chatMemberInfoSubscription.cancel();
    }

    return super.close();
  }

}
