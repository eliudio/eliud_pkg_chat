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
        super(ChatMediumListLoading()) {
    on <LoadChatMediumList> ((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatMediumListToState();
      } else {
        _mapLoadChatMediumListWithDetailsToState();
      }
    });
    
    on <NewPage> ((event, emit) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadChatMediumListWithDetailsToState();
    });
    
    on <ChatMediumChangeQuery> ((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatMediumListToState();
      } else {
        _mapLoadChatMediumListWithDetailsToState();
      }
    });
      
    on <AddChatMediumList> ((event, emit) async {
      await _mapAddChatMediumListToState(event);
    });
    
    on <UpdateChatMediumList> ((event, emit) async {
      await _mapUpdateChatMediumListToState(event);
    });
    
    on <DeleteChatMediumList> ((event, emit) async {
      await _mapDeleteChatMediumListToState(event);
    });
    
    on <ChatMediumListUpdated> ((event, emit) {
      emit(_mapChatMediumListUpdatedToState(event));
    });
  }

  Future<void> _mapLoadChatMediumListToState() async {
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

  Future<void> _mapLoadChatMediumListWithDetailsToState() async {
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

  Future<void> _mapAddChatMediumListToState(AddChatMediumList event) async {
    var value = event.value;
    if (value != null) {
      await _chatMediumRepository.add(value);
    }
  }

  Future<void> _mapUpdateChatMediumListToState(UpdateChatMediumList event) async {
    var value = event.value;
    if (value != null) {
      await _chatMediumRepository.update(value);
    }
  }

  Future<void> _mapDeleteChatMediumListToState(DeleteChatMediumList event) async {
    var value = event.value;
    if (value != null) {
      await _chatMediumRepository.delete(value);
    }
  }

  ChatMediumListLoaded _mapChatMediumListUpdatedToState(
      ChatMediumListUpdated event) => ChatMediumListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _chatMediumsListSubscription?.cancel();
    return super.close();
  }
}


