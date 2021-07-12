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

  ChatDashboardComponentBloc({ this.chatDashboardRepository }): super(ChatDashboardComponentUninitialized());
  @override
  Stream<ChatDashboardComponentState> mapEventToState(ChatDashboardComponentEvent event) async* {
    final currentState = state;
    if (event is FetchChatDashboardComponent) {
      try {
        if (currentState is ChatDashboardComponentUninitialized) {
          bool permissionDenied = false;
          final model = await chatDashboardRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield ChatDashboardComponentPermissionDenied();
          } else {
            if (model != null) {
              yield ChatDashboardComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield ChatDashboardComponentError(
                  message: "ChatDashboard with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield ChatDashboardComponentError(message: "Unknown error whilst retrieving ChatDashboard");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

