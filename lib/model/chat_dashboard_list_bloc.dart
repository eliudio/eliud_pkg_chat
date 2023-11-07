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

import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'chat_dashboard_model.dart';

typedef FilterChatDashboardModels = List<ChatDashboardModel?> Function(
    List<ChatDashboardModel?> values);

class ChatDashboardListBloc
    extends Bloc<ChatDashboardListEvent, ChatDashboardListState> {
  final FilterChatDashboardModels? filter;
  final ChatDashboardRepository _chatDashboardRepository;
  StreamSubscription? _chatDashboardsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatDashboardLimit;

  ChatDashboardListBloc(
      {this.filter,
      this.paged,
      this.orderBy,
      this.descending,
      this.detailed,
      this.eliudQuery,
      required ChatDashboardRepository chatDashboardRepository,
      this.chatDashboardLimit = 5})
      : _chatDashboardRepository = chatDashboardRepository,
        super(ChatDashboardListLoading()) {
    on<LoadChatDashboardList>((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatDashboardListToState();
      } else {
        _mapLoadChatDashboardListWithDetailsToState();
      }
    });

    on<NewPage>((event, emit) {
      pages = pages +
          1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadChatDashboardListWithDetailsToState();
    });

    on<ChatDashboardChangeQuery>((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatDashboardListToState();
      } else {
        _mapLoadChatDashboardListWithDetailsToState();
      }
    });

    on<AddChatDashboardList>((event, emit) async {
      await _mapAddChatDashboardListToState(event);
    });

    on<UpdateChatDashboardList>((event, emit) async {
      await _mapUpdateChatDashboardListToState(event);
    });

    on<DeleteChatDashboardList>((event, emit) async {
      await _mapDeleteChatDashboardListToState(event);
    });

    on<ChatDashboardListUpdated>((event, emit) {
      emit(_mapChatDashboardListUpdatedToState(event));
    });
  }

  List<ChatDashboardModel?> _filter(List<ChatDashboardModel?> original) {
    if (filter != null) {
      return filter!(original);
    } else {
      return original;
    }
  }

  Future<void> _mapLoadChatDashboardListToState() async {
    int amountNow = (state is ChatDashboardListLoaded)
        ? (state as ChatDashboardListLoaded).values!.length
        : 0;
    _chatDashboardsListSubscription?.cancel();
    _chatDashboardsListSubscription = _chatDashboardRepository.listen(
        (list) => add(ChatDashboardListUpdated(
            value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * chatDashboardLimit : null);
  }

  Future<void> _mapLoadChatDashboardListWithDetailsToState() async {
    int amountNow = (state is ChatDashboardListLoaded)
        ? (state as ChatDashboardListLoaded).values!.length
        : 0;
    _chatDashboardsListSubscription?.cancel();
    _chatDashboardsListSubscription =
        _chatDashboardRepository.listenWithDetails(
            (list) => add(ChatDashboardListUpdated(
                value: _filter(list), mightHaveMore: amountNow != list.length)),
            orderBy: orderBy,
            descending: descending,
            eliudQuery: eliudQuery,
            limit: ((paged != null) && paged!)
                ? pages * chatDashboardLimit
                : null);
  }

  Future<void> _mapAddChatDashboardListToState(
      AddChatDashboardList event) async {
    var value = event.value;
    if (value != null) {
      await _chatDashboardRepository.add(value);
    }
  }

  Future<void> _mapUpdateChatDashboardListToState(
      UpdateChatDashboardList event) async {
    var value = event.value;
    if (value != null) {
      await _chatDashboardRepository.update(value);
    }
  }

  Future<void> _mapDeleteChatDashboardListToState(
      DeleteChatDashboardList event) async {
    var value = event.value;
    if (value != null) {
      await _chatDashboardRepository.delete(value);
    }
  }

  ChatDashboardListLoaded _mapChatDashboardListUpdatedToState(
          ChatDashboardListUpdated event) =>
      ChatDashboardListLoaded(
          values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _chatDashboardsListSubscription?.cancel();
    return super.close();
  }
}
