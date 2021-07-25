/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _chatsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatLimit;

  ChatListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required ChatRepository chatRepository, this.chatLimit = 5})
      : assert(chatRepository != null),
        _chatRepository = chatRepository,
        super(ChatListLoading());

  Stream<ChatListState> _mapLoadChatListToState() async* {
    int amountNow =  (state is ChatListLoaded) ? (state as ChatListLoaded).values!.length : 0;
    _chatsListSubscription?.cancel();
    _chatsListSubscription = _chatRepository.listen(
          (list) => add(ChatListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * chatLimit : null
    );
  }

  Stream<ChatListState> _mapLoadChatListWithDetailsToState() async* {
    int amountNow =  (state is ChatListLoaded) ? (state as ChatListLoaded).values!.length : 0;
    _chatsListSubscription?.cancel();
    _chatsListSubscription = _chatRepository.listenWithDetails(
            (list) => add(ChatListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * chatLimit : null
    );
  }

  Stream<ChatListState> _mapAddChatListToState(AddChatList event) async* {
    var value = event.value;
    if (value != null) 
      _chatRepository.add(value);
  }

  Stream<ChatListState> _mapUpdateChatListToState(UpdateChatList event) async* {
    var value = event.value;
    if (value != null) 
      _chatRepository.update(value);
  }

  Stream<ChatListState> _mapDeleteChatListToState(DeleteChatList event) async* {
    var value = event.value;
    if (value != null) 
      _chatRepository.delete(value);
  }

  Stream<ChatListState> _mapChatListUpdatedToState(
      ChatListUpdated event) async* {
    yield ChatListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ChatListState> mapEventToState(ChatListEvent event) async* {
    if (event is LoadChatList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadChatListToState();
      } else {
        yield* _mapLoadChatListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadChatListWithDetailsToState();
    } else if (event is AddChatList) {
      yield* _mapAddChatListToState(event);
    } else if (event is UpdateChatList) {
      yield* _mapUpdateChatListToState(event);
    } else if (event is DeleteChatList) {
      yield* _mapDeleteChatListToState(event);
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


