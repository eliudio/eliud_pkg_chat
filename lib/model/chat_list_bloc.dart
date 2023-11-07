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

import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'chat_model.dart';

typedef FilterChatModels = List<ChatModel?> Function(List<ChatModel?> values);

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final FilterChatModels? filter;
  final ChatRepository _chatRepository;
  StreamSubscription? _chatsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatLimit;

  ChatListBloc(
      {this.filter,
      this.paged,
      this.orderBy,
      this.descending,
      this.detailed,
      this.eliudQuery,
      required ChatRepository chatRepository,
      this.chatLimit = 5})
      : _chatRepository = chatRepository,
        super(ChatListLoading()) {
    on<LoadChatList>((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatListToState();
      } else {
        _mapLoadChatListWithDetailsToState();
      }
    });

    on<NewPage>((event, emit) {
      pages = pages +
          1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadChatListWithDetailsToState();
    });

    on<ChatChangeQuery>((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatListToState();
      } else {
        _mapLoadChatListWithDetailsToState();
      }
    });

    on<AddChatList>((event, emit) async {
      await _mapAddChatListToState(event);
    });

    on<UpdateChatList>((event, emit) async {
      await _mapUpdateChatListToState(event);
    });

    on<DeleteChatList>((event, emit) async {
      await _mapDeleteChatListToState(event);
    });

    on<ChatListUpdated>((event, emit) {
      emit(_mapChatListUpdatedToState(event));
    });
  }

  List<ChatModel?> _filter(List<ChatModel?> original) {
    if (filter != null) {
      return filter!(original);
    } else {
      return original;
    }
  }

  Future<void> _mapLoadChatListToState() async {
    int amountNow = (state is ChatListLoaded)
        ? (state as ChatListLoaded).values!.length
        : 0;
    _chatsListSubscription?.cancel();
    _chatsListSubscription = _chatRepository.listen(
        (list) => add(ChatListUpdated(
            value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * chatLimit : null);
  }

  Future<void> _mapLoadChatListWithDetailsToState() async {
    int amountNow = (state is ChatListLoaded)
        ? (state as ChatListLoaded).values!.length
        : 0;
    _chatsListSubscription?.cancel();
    _chatsListSubscription = _chatRepository.listenWithDetails(
        (list) => add(ChatListUpdated(
            value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * chatLimit : null);
  }

  Future<void> _mapAddChatListToState(AddChatList event) async {
    var value = event.value;
    if (value != null) {
      await _chatRepository.add(value);
    }
  }

  Future<void> _mapUpdateChatListToState(UpdateChatList event) async {
    var value = event.value;
    if (value != null) {
      await _chatRepository.update(value);
    }
  }

  Future<void> _mapDeleteChatListToState(DeleteChatList event) async {
    var value = event.value;
    if (value != null) {
      await _chatRepository.delete(value);
    }
  }

  ChatListLoaded _mapChatListUpdatedToState(ChatListUpdated event) =>
      ChatListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _chatsListSubscription?.cancel();
    return super.close();
  }
}
