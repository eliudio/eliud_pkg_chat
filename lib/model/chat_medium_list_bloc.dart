/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/chat_medium_repository.dart';
import 'package:eliud_pkg_chat/model/chat_medium_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class ChatMediumListBloc extends Bloc<ChatMediumListEvent, ChatMediumListState> {
  final ChatMediumRepository _chatMediumRepository;
  StreamSubscription? _chatMediumsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatMediumLimit;

  ChatMediumListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required ChatMediumRepository chatMediumRepository, this.chatMediumLimit = 5})
      : assert(chatMediumRepository != null),
        _chatMediumRepository = chatMediumRepository,
        super(ChatMediumListLoading());

  Stream<ChatMediumListState> _mapLoadChatMediumListToState() async* {
    int amountNow =  (state is ChatMediumListLoaded) ? (state as ChatMediumListLoaded).values!.length : 0;
    _chatMediumsListSubscription?.cancel();
    _chatMediumsListSubscription = _chatMediumRepository.listen(
          (list) => add(ChatMediumListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * chatMediumLimit : null
    );
  }

  Stream<ChatMediumListState> _mapLoadChatMediumListWithDetailsToState() async* {
    int amountNow =  (state is ChatMediumListLoaded) ? (state as ChatMediumListLoaded).values!.length : 0;
    _chatMediumsListSubscription?.cancel();
    _chatMediumsListSubscription = _chatMediumRepository.listenWithDetails(
            (list) => add(ChatMediumListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * chatMediumLimit : null
    );
  }

  Stream<ChatMediumListState> _mapAddChatMediumListToState(AddChatMediumList event) async* {
    var value = event.value;
    if (value != null) 
      _chatMediumRepository.add(value);
  }

  Stream<ChatMediumListState> _mapUpdateChatMediumListToState(UpdateChatMediumList event) async* {
    var value = event.value;
    if (value != null) 
      _chatMediumRepository.update(value);
  }

  Stream<ChatMediumListState> _mapDeleteChatMediumListToState(DeleteChatMediumList event) async* {
    var value = event.value;
    if (value != null) 
      _chatMediumRepository.delete(value);
  }

  Stream<ChatMediumListState> _mapChatMediumListUpdatedToState(
      ChatMediumListUpdated event) async* {
    yield ChatMediumListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ChatMediumListState> mapEventToState(ChatMediumListEvent event) async* {
    if (event is LoadChatMediumList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadChatMediumListToState();
      } else {
        yield* _mapLoadChatMediumListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadChatMediumListWithDetailsToState();
    } else if (event is ChatMediumChangeQuery) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadChatMediumListToState();
      } else {
        yield* _mapLoadChatMediumListWithDetailsToState();
      }
    } else if (event is AddChatMediumList) {
      yield* _mapAddChatMediumListToState(event);
    } else if (event is UpdateChatMediumList) {
      yield* _mapUpdateChatMediumListToState(event);
    } else if (event is DeleteChatMediumList) {
      yield* _mapDeleteChatMediumListToState(event);
    } else if (event is ChatMediumListUpdated) {
      yield* _mapChatMediumListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _chatMediumsListSubscription?.cancel();
    return super.close();
  }
}


