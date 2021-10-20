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
  StreamSubscription? _chatSubscription;

  Stream<ChatComponentState> _mapLoadChatComponentUpdateToState(String documentId) async* {
    _chatSubscription?.cancel();
    _chatSubscription = chatRepository!.listenTo(documentId, (value) {
      if (value != null) add(ChatComponentUpdated(value: value));
    });
  }

  ChatComponentBloc({ this.chatRepository }): super(ChatComponentUninitialized());

  @override
  Stream<ChatComponentState> mapEventToState(ChatComponentEvent event) async* {
    final currentState = state;
    if (event is FetchChatComponent) {
      yield* _mapLoadChatComponentUpdateToState(event.id!);
    } else if (event is ChatComponentUpdated) {
      yield ChatComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }

}

