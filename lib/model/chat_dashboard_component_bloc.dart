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

import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component_state.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';
import 'package:flutter/services.dart';

class ChatDashboardComponentBloc extends Bloc<ChatDashboardComponentEvent, ChatDashboardComponentState> {
  final ChatDashboardRepository? chatDashboardRepository;
  StreamSubscription? _chatDashboardSubscription;

  Stream<ChatDashboardComponentState> _mapLoadChatDashboardComponentUpdateToState(String documentId) async* {
    _chatDashboardSubscription?.cancel();
    _chatDashboardSubscription = chatDashboardRepository!.listenTo(documentId, (value) {
      if (value != null) add(ChatDashboardComponentUpdated(value: value!));
    });
  }

  ChatDashboardComponentBloc({ this.chatDashboardRepository }): super(ChatDashboardComponentUninitialized());

  @override
  Stream<ChatDashboardComponentState> mapEventToState(ChatDashboardComponentEvent event) async* {
    final currentState = state;
    if (event is FetchChatDashboardComponent) {
      yield* _mapLoadChatDashboardComponentUpdateToState(event.id!);
    } else if (event is ChatDashboardComponentUpdated) {
      yield ChatDashboardComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _chatDashboardSubscription?.cancel();
    return super.close();
  }

}

