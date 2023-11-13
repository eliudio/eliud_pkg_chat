/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_chat/model/chat_dashboard_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component_state.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';

class ChatDashboardComponentBloc
    extends Bloc<ChatDashboardComponentEvent, ChatDashboardComponentState> {
  final ChatDashboardRepository? chatDashboardRepository;
  StreamSubscription? _chatDashboardSubscription;

  void _mapLoadChatDashboardComponentUpdateToState(String documentId) {
    _chatDashboardSubscription?.cancel();
    _chatDashboardSubscription =
        chatDashboardRepository!.listenTo(documentId, (value) {
      if (value != null) {
        add(ChatDashboardComponentUpdated(value: value));
      }
    });
  }

  /*
   * Construct ChatDashboardComponentBloc
   */
  ChatDashboardComponentBloc({this.chatDashboardRepository})
      : super(ChatDashboardComponentUninitialized()) {
    on<FetchChatDashboardComponent>((event, emit) {
      _mapLoadChatDashboardComponentUpdateToState(event.id!);
    });
    on<ChatDashboardComponentUpdated>((event, emit) {
      emit(ChatDashboardComponentLoaded(value: event.value));
    });
  }

  /*
   * Close the ChatDashboardComponentBloc
   */
  @override
  Future<void> close() {
    _chatDashboardSubscription?.cancel();
    return super.close();
  }
}
