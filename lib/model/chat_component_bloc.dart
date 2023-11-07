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

import 'package:eliud_pkg_chat/model/chat_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_component_state.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';

class ChatComponentBloc extends Bloc<ChatComponentEvent, ChatComponentState> {
  final ChatRepository? chatRepository;
  StreamSubscription? _chatSubscription;

  void _mapLoadChatComponentUpdateToState(String documentId) {
    _chatSubscription?.cancel();
    _chatSubscription = chatRepository!.listenTo(documentId, (value) {
      if (value != null) {
        add(ChatComponentUpdated(value: value));
      }
    });
  }

  ChatComponentBloc({this.chatRepository})
      : super(ChatComponentUninitialized()) {
    on<FetchChatComponent>((event, emit) {
      _mapLoadChatComponentUpdateToState(event.id!);
    });
    on<ChatComponentUpdated>((event, emit) {
      emit(ChatComponentLoaded(value: event.value));
    });
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
