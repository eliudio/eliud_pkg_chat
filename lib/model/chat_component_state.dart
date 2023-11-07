/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';

abstract class ChatComponentState extends Equatable {
  const ChatComponentState();

  @override
  List<Object?> get props => [];
}

class ChatComponentUninitialized extends ChatComponentState {}

class ChatComponentError extends ChatComponentState {
  final String? message;
  ChatComponentError({this.message});
}

class ChatComponentPermissionDenied extends ChatComponentState {
  ChatComponentPermissionDenied();
}

class ChatComponentLoaded extends ChatComponentState {
  final ChatModel value;

  const ChatComponentLoaded({required this.value});

  ChatComponentLoaded copyWith({ChatModel? copyThis}) {
    return ChatComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChatComponentLoaded { value: $value }';
}
