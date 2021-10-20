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
  StreamSubscription? _chatMemberInfoSubscription;

  Stream<ChatMemberInfoComponentState> _mapLoadChatMemberInfoComponentUpdateToState(String documentId) async* {
    _chatMemberInfoSubscription?.cancel();
    _chatMemberInfoSubscription = chatMemberInfoRepository!.listenTo(documentId, (value) {
      if (value != null) add(ChatMemberInfoComponentUpdated(value: value));
    });
  }

  ChatMemberInfoComponentBloc({ this.chatMemberInfoRepository }): super(ChatMemberInfoComponentUninitialized());

  @override
  Stream<ChatMemberInfoComponentState> mapEventToState(ChatMemberInfoComponentEvent event) async* {
    final currentState = state;
    if (event is FetchChatMemberInfoComponent) {
      yield* _mapLoadChatMemberInfoComponentUpdateToState(event.id!);
    } else if (event is ChatMemberInfoComponentUpdated) {
      yield ChatMemberInfoComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _chatMemberInfoSubscription?.cancel();
    return super.close();
  }

}

