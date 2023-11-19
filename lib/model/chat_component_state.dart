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

/* 
 * ChatComponentState is the base class for state for ChatComponentBloc
 */
abstract class ChatComponentState extends Equatable {
  const ChatComponentState();

  @override
  List<Object?> get props => [];
}

/* 
 * ChatComponentUninitialized is the uninitialized state of the ChatComponentBloc 
 */
class ChatComponentUninitialized extends ChatComponentState {}

/* 
 * ChatComponentError is the error state of the ChatComponentBloc 
 */
class ChatComponentError extends ChatComponentState {
  final String? message;
  ChatComponentError({ this.message });
}

/* 
 * ChatComponentPermissionDenied is to indicate permission denied state of the ChatComponentBloc 
 */
class ChatComponentPermissionDenied extends ChatComponentState {
  ChatComponentPermissionDenied();
}

/* 
 * ChatComponentLoaded is used to set the state of the ChatComponentBloc to the loaded state
 */
class ChatComponentLoaded extends ChatComponentState {
  final ChatModel value;

  /* 
   * construct ChatComponentLoaded
   */
  const ChatComponentLoaded({ required this.value });

  /* 
   * copy method
   */
  ChatComponentLoaded copyWith({ ChatModel? copyThis }) {
    return ChatComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChatComponentLoaded { value: $value }';
}

