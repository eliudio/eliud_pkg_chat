import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core_helpers/query/query_tools.dart';
import 'package:eliud_pkg_chat/extensions/widgets/all_chats_bloc/all_chats_state.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:eliud_pkg_chat_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat_model/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat_model/model/chat_model.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  StreamSubscription? _chatsListSubscription;
  late EliudQuery eliudQuery;
  int pages = 1;
  final String appId;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatLimit;
  final String thisMemberId;
  final List<String> blockedMembers;

  void _mapLoadChatWithDetailsToState(EnhancedRoomModel room) {
    var appId = room.roomModel.appId;
    var roomId = room.roomModel.documentID;
    int amountNow =
        (state is ChatLoaded) ? (state as ChatLoaded).values.length : 0;
    _chatsListSubscription?.cancel();
    _chatsListSubscription = chatRepository(appId: appId, roomId: roomId)!
        .listenWithDetails((list) async {
      List<ChatModel?> newList = [];
      for (var element in list) {
        if ((element != null) && (!blockedMembers.contains(element.authorId))) {
          newList.add(element);
        }
      }

      if (newList.isNotEmpty) {
        add(ChatUpdated(
            value: newList.map((value) => value!).toList(),
            mightHaveMore: amountNow != list.length,
            room: room));
      }
    },
            orderBy: orderBy,
            descending: descending,
            eliudQuery: eliudQuery,
            limit: ((paged != null) && paged!) ? pages * chatLimit : null);
  }

  Future<void> _mapAddChatToState(EnhancedRoomModel room, AddChat event) async {
    var value = event.value;
    if (value != null) {
      var newValue = await chatRepository(
              appId: event.value!.appId, roomId: event.value!.roomId!)!
          .add(value);
      markAsRead(room, newValue);
    }
  }

  ChatState _mapChatUpdatedToState(ChatUpdated event) {
    return ChatLoaded(
        room: event.room,
        values: event.value,
        mightHaveMore: event.mightHaveMore);
  }

  ChatBloc(
      {required this.appId,
      required this.thisMemberId,
      required this.blockedMembers,
      this.paged = true,
      this.orderBy = 'timestamp',
      this.descending = true,
      this.detailed = true,
      this.chatLimit = 100})
      : super(ChatLoading()) {
    eliudQuery = EliudQuery().withCondition(
        EliudQueryCondition('readAccess', arrayContains: thisMemberId));
    on<SelectChatEvent>((event, emit) {
      _mapLoadChatWithDetailsToState(event.room);
    });

    on<OpenChatWithAMemberEvent>((event, emit) async {
      var roomModel = await RoomHelper.getRoomForMembers(
          appId, thisMemberId, [thisMemberId, event.otherMember]);
      var otherMemberRoomInfo = await RoomHelper.getOtherMembersRoomInfo(
          thisMemberId, appId, roomModel.members!);
      var enhancedRoomModel =
          EnhancedRoomModel(roomModel, null, otherMemberRoomInfo, null);
      _mapLoadChatWithDetailsToState(enhancedRoomModel);
      emit(ChatLoaded(room: enhancedRoomModel, mightHaveMore: true));
    });

    on<OpenChatWithMembersEvent>((event, emit) async {
      var roomModel = await RoomHelper.getRoomForMembers(
          appId, thisMemberId, event.members);
      var otherMemberRoomInfo = await RoomHelper.getOtherMembersRoomInfo(
          thisMemberId, appId, roomModel.members!);
      var enhancedRoomModel =
          EnhancedRoomModel(roomModel, null, otherMemberRoomInfo, null);
      _mapLoadChatWithDetailsToState(enhancedRoomModel);
      emit(ChatLoaded(room: enhancedRoomModel, mightHaveMore: true));
    });

    on<UpdateEnhancedRoomModel>((event, emit) {
      var theState = state;
      if (theState is ChatLoaded) {
        if ((theState.room.roomModel.documentID ==
                event.model.roomModel.documentID) &&
            (theState.room.roomModel.appId == event.model.roomModel.appId)) {
          emit(theState.withNewEnhancedRoomModel(event.model));
        }
      }
    });

    on<NewChatPage>((event, emit) {
      var theState = state;
      if (theState is ChatLoaded) {
        pages = pages +
            1; // it doesn't matter so much if we increase pages beyond the end
        _mapLoadChatWithDetailsToState(theState.room);
      }
    });

    on<AddChat>((event, emit) {
      var theState = state;
      if (theState is ChatLoaded) {
        _mapAddChatToState(theState.room, event);
      }
    });

    on<ChatUpdated>((event, emit) {
      emit(_mapChatUpdatedToState(event));
    });

    on<MarkAsRead>((event, emit) {
      var room = event.enhancedRoomModel;
      var item = event.chat;
      markAsRead(room, item);
    });
  }

  Future<void> markAsRead(EnhancedRoomModel room, ChatModel item) async {
    var roomId = room.roomModel.documentID;
    if ((room.timeStampThisMemberRead == null) ||
        (item.timestamp != null) &&
            (item.timestamp!.compareTo(room.timeStampThisMemberRead!) > 0)) {
      try {
        await chatMemberInfoRepository(
                appId: room.roomModel.appId, roomId: roomId)!
            .add(ChatMemberInfoModel(
          appId: room.roomModel.appId,
          documentID: RoomHelper.getChatMemberInfoId(thisMemberId, roomId),
          authorId: thisMemberId,
          roomId: roomId,
          accessibleByGroup: ChatMemberInfoAccessibleByGroup.specificMembers,
          accessibleByMembers: room.roomModel.members,
          readAccess: [
            thisMemberId
          ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
        ));
      } catch (_) {
        // issue with timestamp: ignore
      }
    }
  }

  @override
  Future<void> close() {
    _chatsListSubscription?.cancel();
    return super.close();
  }
}
