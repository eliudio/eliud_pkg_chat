/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_chat/model/chat_interactions_model.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_component_state.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_repository.dart';
import 'package:flutter/services.dart';

class ChatInteractionsComponentBloc extends Bloc<ChatInteractionsComponentEvent, ChatInteractionsComponentState> {
  final ChatInteractionsRepository? chatInteractionsRepository;

  ChatInteractionsComponentBloc({ this.chatInteractionsRepository }): super(ChatInteractionsComponentUninitialized());
  @override
  Stream<ChatInteractionsComponentState> mapEventToState(ChatInteractionsComponentEvent event) async* {
    final currentState = state;
    if (event is FetchChatInteractionsComponent) {
      try {
        if (currentState is ChatInteractionsComponentUninitialized) {
          bool permissionDenied = false;
          final model = await chatInteractionsRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield ChatInteractionsComponentPermissionDenied();
          } else {
            if (model != null) {
              yield ChatInteractionsComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield ChatInteractionsComponentError(
                  message: "ChatInteractions with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield ChatInteractionsComponentError(message: "Unknown error whilst retrieving ChatInteractions");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

