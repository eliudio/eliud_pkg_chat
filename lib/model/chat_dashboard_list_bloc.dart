/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _chatDashboardLimit = 5;

class ChatDashboardListBloc extends Bloc<ChatDashboardListEvent, ChatDashboardListState> {
  final ChatDashboardRepository _chatDashboardRepository;
  StreamSubscription? _chatDashboardsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;

  ChatDashboardListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required ChatDashboardRepository chatDashboardRepository})
      : assert(chatDashboardRepository != null),
        _chatDashboardRepository = chatDashboardRepository,
        super(ChatDashboardListLoading());

  Stream<ChatDashboardListState> _mapLoadChatDashboardListToState() async* {
    int amountNow =  (state is ChatDashboardListLoaded) ? (state as ChatDashboardListLoaded).values!.length : 0;
    _chatDashboardsListSubscription?.cancel();
    _chatDashboardsListSubscription = _chatDashboardRepository.listen(
          (list) => add(ChatDashboardListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * _chatDashboardLimit : null
    );
  }

  Stream<ChatDashboardListState> _mapLoadChatDashboardListWithDetailsToState() async* {
    int amountNow =  (state is ChatDashboardListLoaded) ? (state as ChatDashboardListLoaded).values!.length : 0;
    _chatDashboardsListSubscription?.cancel();
    _chatDashboardsListSubscription = _chatDashboardRepository.listenWithDetails(
            (list) => add(ChatDashboardListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * _chatDashboardLimit : null
    );
  }

  Stream<ChatDashboardListState> _mapAddChatDashboardListToState(AddChatDashboardList event) async* {
    var value = event.value;
    if (value != null) 
      _chatDashboardRepository.add(value);
  }

  Stream<ChatDashboardListState> _mapUpdateChatDashboardListToState(UpdateChatDashboardList event) async* {
    var value = event.value;
    if (value != null) 
      _chatDashboardRepository.update(value);
  }

  Stream<ChatDashboardListState> _mapDeleteChatDashboardListToState(DeleteChatDashboardList event) async* {
    var value = event.value;
    if (value != null) 
      _chatDashboardRepository.delete(value);
  }

  Stream<ChatDashboardListState> _mapChatDashboardListUpdatedToState(
      ChatDashboardListUpdated event) async* {
    yield ChatDashboardListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ChatDashboardListState> mapEventToState(ChatDashboardListEvent event) async* {
    if (event is LoadChatDashboardList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadChatDashboardListToState();
      } else {
        yield* _mapLoadChatDashboardListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadChatDashboardListWithDetailsToState();
    } else if (event is AddChatDashboardList) {
      yield* _mapAddChatDashboardListToState(event);
    } else if (event is UpdateChatDashboardList) {
      yield* _mapUpdateChatDashboardListToState(event);
    } else if (event is DeleteChatDashboardList) {
      yield* _mapDeleteChatDashboardListToState(event);
    } else if (event is ChatDashboardListUpdated) {
      yield* _mapChatDashboardListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _chatDashboardsListSubscription?.cancel();
    return super.close();
  }
}


