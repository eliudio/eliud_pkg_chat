import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
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

  ChatListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, this.chatLimit = 5})
      : super(ChatListLoading());

  Stream<ChatListState> _mapLoadChatListWithDetailsToState(RoomModel room) async* {
    int amountNow =  (state is ChatListLoaded) ? (state as ChatListLoaded).values.length : 0;
    _chatsListSubscription?.cancel();
    _chatsListSubscription = chatRepository(appId: room.appId, roomId: room.documentID)!.listenWithDetails(
            (list) => add(ChatListUpdated(value: list, mightHaveMore: amountNow != list.length, room: room)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * chatLimit : null
    );
  }

  void _mapAddChatListToState(AddChatList event) {
    var value = event.value;
    if (value != null) {
      chatRepository(appId: event.value!.appId, roomId: event.value!.roomId!)!.add(value);
    }
  }

  Stream<ChatListState> _mapChatListUpdatedToState(
      ChatListUpdated event) async* {
    yield ChatListLoaded(room: event.room, values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ChatListState> mapEventToState(ChatListEvent event) async* {
    if (event is LoadChatList) {
      yield* _mapLoadChatListWithDetailsToState(event.room);
    }
    if (event is NewChatPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadChatListWithDetailsToState(event.room);
    } else if (event is AddChatList) {
      _mapAddChatListToState(event);
    } else if (event is ChatListUpdated) {
      yield* _mapChatListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _chatsListSubscription?.cancel();
    return super.close();
  }
}
