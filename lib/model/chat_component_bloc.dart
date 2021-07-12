/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_component_state.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:flutter/services.dart';

class ChatComponentBloc extends Bloc<ChatComponentEvent, ChatComponentState> {
  final ChatRepository? chatRepository;

  ChatComponentBloc({ this.chatRepository }): super(ChatComponentUninitialized());
  @override
  Stream<ChatComponentState> mapEventToState(ChatComponentEvent event) async* {
    final currentState = state;
    if (event is FetchChatComponent) {
      try {
        if (currentState is ChatComponentUninitialized) {
          bool permissionDenied = false;
          final model = await chatRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield ChatComponentPermissionDenied();
          } else {
            if (model != null) {
              yield ChatComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield ChatComponentError(
                  message: "Chat with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield ChatComponentError(message: "Unknown error whilst retrieving Chat");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

