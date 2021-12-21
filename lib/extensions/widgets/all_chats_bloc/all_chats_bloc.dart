import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'all_chats_event.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/room_repository.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'all_chats_state.dart';

class AllChatsBloc extends Bloc<AllChatsEvent, AllChatsState> {
  final RoomRepository _roomRepository;
  StreamSubscription? _roomsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final int roomLimit;
  final String thisMemberId;

  AllChatsBloc(
      {required this.thisMemberId,
      this.paged,
      this.orderBy,
      this.descending,
      this.eliudQuery,
      required RoomRepository roomRepository,
      this.roomLimit = 5})
      : assert(roomRepository != null),
        _roomRepository = roomRepository,
        super(AllChatsLoading());

  Future<List<ChatMemberInfoModel?>>? getLastReadForThisMember(
      String appId, String roomId, String memberId) async {
    return await chatMemberInfoRepository(appId: appId, roomId: roomId)!
        .valuesList(
            eliudQuery: EliudQuery().withCondition(
                EliudQueryCondition('readAccess', arrayContains: memberId)));
  }

  Stream<AllChatsState> _mapLoadAllChatsWithDetailsToState() async* {
    int amountNow = (state is AllChatsLoaded)
        ? (state as AllChatsLoaded).values!.length
        : 0;
    _roomsListSubscription?.cancel();
    _roomsListSubscription = _roomRepository.listenWithDetails((list) async {
      var enhancedList = await Future.wait(list.map((value) async {
        var otherMemberRoomInfo =
            await getOtherMembersRoomInfo(value!.appId!, value.members!);

        var memberLastRead;
        var chatMemberInfoModels = await getLastReadForThisMember(value.appId!, value.documentID!, thisMemberId);
        var memberValue = chatMemberInfoModels!.firstWhere((element) => element!.authorId == thisMemberId, orElse: () => null);
        if ((memberValue != null) &&
            (memberValue.timestamp != null)) {
          try {
            memberLastRead = memberValue.timestamp!;
          } catch (_) {}
        }

        return EnhancedRoomModel(value, memberLastRead, otherMemberRoomInfo);
      }).toList());
      add(AllChatsUpdated(
          value: enhancedList, mightHaveMore: amountNow != list.length));
    },
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * roomLimit : null);
  }

  Stream<AllChatsState> _mapAddAllChatsToState(AddAllChats event) async* {
    var value = event.value;
    if (value != null) _roomRepository.add(value);
  }

  Stream<AllChatsState> _mapUpdateAllChatsToState(UpdateAllChats event) async* {
    var value = event.value;
    if (value != null) _roomRepository.update(value);
  }

  Stream<AllChatsState> _mapDeleteAllChatsToState(DeleteAllChats event) async* {
    var value = event.value;
    if (value != null) _roomRepository.delete(value);
  }

  Stream<AllChatsState> _mapAllChatsUpdatedToState(
      AllChatsUpdated event, RoomModel? currentRoom) async* {
    yield AllChatsLoaded(
        values: event.value,
        mightHaveMore: event.mightHaveMore,
        currentRoom: currentRoom);
  }

  @override
  Stream<AllChatsState> mapEventToState(AllChatsEvent event) async* {
    var theState = state;
    if (event is LoadAllChats) {
      yield* _mapLoadAllChatsWithDetailsToState();
    }
    if (event is NewPage) {
      pages = pages +
          1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadAllChatsWithDetailsToState();
    } else if (event is AddAllChats) {
      yield* _mapAddAllChatsToState(event);
    } else if (event is UpdateAllChats) {
      yield* _mapUpdateAllChatsToState(event);
    } else if (event is DeleteAllChats) {
      yield* _mapDeleteAllChatsToState(event);
    } else if (event is AllChatsUpdated) {
      var currentRoom = (theState is AllChatsLoaded)
          ? theState.currentRoom
          : ((event.value.isNotEmpty) ? event.value[0].roomModel : null);
      yield* _mapAllChatsUpdatedToState(event, currentRoom);
    } else if (event is SelectChat) {
      if (theState is AllChatsLoaded) {
        yield AllChatsLoaded(
            values: theState.values,
            mightHaveMore: theState.mightHaveMore,
            currentRoom: event.selected);
      } else {
        throw Exception("Unexpected state");
      }
    }
  }

  @override
  Future<void> close() {
    _roomsListSubscription?.cancel();
    return super.close();
  }

  Future<List<OtherMemberRoomInfo>> getOtherMembersRoomInfo(
      String appId, List<String> memberIds) async {
    List<OtherMemberRoomInfo> otherMembersRoomInfo = [];
    for (var memberId in memberIds) {
      if (memberId != thisMemberId) {
        var member =
            await memberPublicInfoRepository(appId: appId)!.get(memberId);
        if (member != null) {
          var otherMemberRoomInfo = OtherMemberRoomInfo(
              name: member.name != null ? member.name! : 'No name',
              avatar: member.photoURL);
          otherMembersRoomInfo.add(otherMemberRoomInfo);
        }
      }
    }
    return otherMembersRoomInfo;
  }
}
