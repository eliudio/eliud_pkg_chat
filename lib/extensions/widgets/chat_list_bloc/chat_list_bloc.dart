import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_pkg_chat/extensions/widgets/all_chats_bloc/all_chats_state.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  StreamSubscription? _chatsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatLimit;
  final String thisMemberId;

  ChatListBloc(
      {required this.thisMemberId,
      this.paged,
      this.orderBy,
      this.descending,
      this.detailed,
      this.eliudQuery,
      this.chatLimit = 5})
      : super(ChatListLoading());

  Stream<ChatListState> _mapLoadChatListWithDetailsToState(
      EnhancedRoomModel room) async* {
    var appId = room.roomModel.appId!;
    var roomId = room.roomModel.documentID!;
    int amountNow =
        (state is ChatListLoaded) ? (state as ChatListLoaded).values.length : 0;
    _chatsListSubscription?.cancel();
    _chatsListSubscription = chatRepository(appId: appId, roomId: roomId)!
        .listenWithDetails((list) async {
      add(ChatListUpdated(
          value: list.map((value) => value!).toList(),
          mightHaveMore: amountNow != list.length,
          room: room));
    },
            orderBy: orderBy,
            descending: descending,
            eliudQuery: eliudQuery,
            limit: ((paged != null) && paged!) ? pages * chatLimit : null);
  }

  Future<void> _mapAddChatListToState(
      EnhancedRoomModel room, AddChatList event) async {
    var value = event.value;
    if (value != null) {
      var newValue = await chatRepository(
              appId: event.value!.appId, roomId: event.value!.roomId!)!
          .add(value);
      markAsRead(room, newValue);
    }
  }

  Stream<ChatListState> _mapChatListUpdatedToState(
      ChatListUpdated event) async* {
    yield ChatListLoaded(
        room: event.room,
        values: event.value,
        mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ChatListState> mapEventToState(ChatListEvent event) async* {
    if (event is SelectChatList) {
      yield* _mapLoadChatListWithDetailsToState(event.room);
    } else if (event is UpdateEnhancedRoomModel) {
      var theState = state;
      if (theState is ChatListLoaded) {
        if ((theState.room.roomModel.documentID ==
                event.model.roomModel.documentID) &&
            (theState.room.roomModel.appId == event.model.roomModel.appId)) {
          yield theState.withNewEnhancedRoomModel(event.model);
        }
      }
    } else if (event is NewChatPage) {
      var theState = state;
      if (theState is ChatListLoaded) {
        pages = pages +
            1; // it doesn't matter so much if we increase pages beyond the end
        yield* _mapLoadChatListWithDetailsToState(theState.room);
      }
    } else if (event is AddChatList) {
      var theState = state;
      if (theState is ChatListLoaded) {
        _mapAddChatListToState(theState.room, event);
      }
    } else if (event is ChatListUpdated) {
      yield* _mapChatListUpdatedToState(event);
    } else if (event is MarkAsRead) {
      var room = event.enhancedRoomModel;
      var item = event.chat;
      markAsRead(room, item);
    }
  }

  Future<void> markAsRead(EnhancedRoomModel room, ChatModel item) async {
    var roomId = room.roomModel.documentID!;
    if ((room.timeStampThisMemberRead == null) ||
        (item.timestamp != null) &&
            (item.timestamp!.compareTo(room.timeStampThisMemberRead!) > 0)) {
      try {
        await chatMemberInfoRepository(
                appId: room.roomModel.appId!, roomId: roomId)!
            .add(ChatMemberInfoModel(
          documentID: RoomHelper.getChatMemberInfoId(thisMemberId, roomId),
          authorId: thisMemberId,
          roomId: roomId,
          readAccess: room.roomModel.members, /*timestamp: item.timestamp*/
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
