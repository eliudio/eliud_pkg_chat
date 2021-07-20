/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_component_state.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_repository.dart';
import 'package:flutter/services.dart';

class ChatMemberInfoComponentBloc extends Bloc<ChatMemberInfoComponentEvent, ChatMemberInfoComponentState> {
  final ChatMemberInfoRepository? chatMemberInfoRepository;

  ChatMemberInfoComponentBloc({ this.chatMemberInfoRepository }): super(ChatMemberInfoComponentUninitialized());
  @override
  Stream<ChatMemberInfoComponentState> mapEventToState(ChatMemberInfoComponentEvent event) async* {
    final currentState = state;
    if (event is FetchChatMemberInfoComponent) {
      try {
        if (currentState is ChatMemberInfoComponentUninitialized) {
          bool permissionDenied = false;
          final model = await chatMemberInfoRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield ChatMemberInfoComponentPermissionDenied();
          } else {
            if (model != null) {
              yield ChatMemberInfoComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield ChatMemberInfoComponentError(
                  message: "ChatMemberInfo with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield ChatMemberInfoComponentError(message: "Unknown error whilst retrieving ChatMemberInfo");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

