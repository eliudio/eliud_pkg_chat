/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_model.dart';

abstract class ChatInteractionsComponentState extends Equatable {
  const ChatInteractionsComponentState();

  @override
  List<Object?> get props => [];
}

class ChatInteractionsComponentUninitialized extends ChatInteractionsComponentState {}

class ChatInteractionsComponentError extends ChatInteractionsComponentState {
  final String? message;
  ChatInteractionsComponentError({ this.message });
}

class ChatInteractionsComponentPermissionDenied extends ChatInteractionsComponentState {
  ChatInteractionsComponentPermissionDenied();
}

class ChatInteractionsComponentLoaded extends ChatInteractionsComponentState {
  final ChatInteractionsModel? value;

  const ChatInteractionsComponentLoaded({ this.value });

  ChatInteractionsComponentLoaded copyWith({ ChatInteractionsModel? copyThis }) {
    return ChatInteractionsComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChatInteractionsComponentLoaded { value: $value }';
}

