/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/chat_interactions_repository.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _chatInteractionsLimit = 5;

class ChatInteractionsListBloc extends Bloc<ChatInteractionsListEvent, ChatInteractionsListState> {
  final ChatInteractionsRepository _chatInteractionsRepository;
  StreamSubscription? _chatInteractionssListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;

  ChatInteractionsListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required ChatInteractionsRepository chatInteractionsRepository})
      : assert(chatInteractionsRepository != null),
        _chatInteractionsRepository = chatInteractionsRepository,
        super(ChatInteractionsListLoading());

  Stream<ChatInteractionsListState> _mapLoadChatInteractionsListToState() async* {
    int amountNow =  (state is ChatInteractionsListLoaded) ? (state as ChatInteractionsListLoaded).values!.length : 0;
    _chatInteractionssListSubscription?.cancel();
    _chatInteractionssListSubscription = _chatInteractionsRepository.listen(
          (list) => add(ChatInteractionsListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * _chatInteractionsLimit : null
    );
  }

  Stream<ChatInteractionsListState> _mapLoadChatInteractionsListWithDetailsToState() async* {
    int amountNow =  (state is ChatInteractionsListLoaded) ? (state as ChatInteractionsListLoaded).values!.length : 0;
    _chatInteractionssListSubscription?.cancel();
    _chatInteractionssListSubscription = _chatInteractionsRepository.listenWithDetails(
            (list) => add(ChatInteractionsListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * _chatInteractionsLimit : null
    );
  }

  Stream<ChatInteractionsListState> _mapAddChatInteractionsListToState(AddChatInteractionsList event) async* {
    var value = event.value;
    if (value != null) 
      _chatInteractionsRepository.add(value);
  }

  Stream<ChatInteractionsListState> _mapUpdateChatInteractionsListToState(UpdateChatInteractionsList event) async* {
    var value = event.value;
    if (value != null) 
      _chatInteractionsRepository.update(value);
  }

  Stream<ChatInteractionsListState> _mapDeleteChatInteractionsListToState(DeleteChatInteractionsList event) async* {
    var value = event.value;
    if (value != null) 
      _chatInteractionsRepository.delete(value);
  }

  Stream<ChatInteractionsListState> _mapChatInteractionsListUpdatedToState(
      ChatInteractionsListUpdated event) async* {
    yield ChatInteractionsListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ChatInteractionsListState> mapEventToState(ChatInteractionsListEvent event) async* {
    if (event is LoadChatInteractionsList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadChatInteractionsListToState();
      } else {
        yield* _mapLoadChatInteractionsListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadChatInteractionsListWithDetailsToState();
    } else if (event is AddChatInteractionsList) {
      yield* _mapAddChatInteractionsListToState(event);
    } else if (event is UpdateChatInteractionsList) {
      yield* _mapUpdateChatInteractionsListToState(event);
    } else if (event is DeleteChatInteractionsList) {
      yield* _mapDeleteChatInteractionsListToState(event);
    } else if (event is ChatInteractionsListUpdated) {
      yield* _mapChatInteractionsListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _chatInteractionssListSubscription?.cancel();
    return super.close();
  }
}


