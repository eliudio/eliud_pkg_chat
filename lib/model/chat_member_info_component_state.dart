/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';

/* 
 * ChatMemberInfoComponentState is the base class for state for ChatMemberInfoComponentBloc
 */
abstract class ChatMemberInfoComponentState extends Equatable {
  const ChatMemberInfoComponentState();

  @override
  List<Object?> get props => [];
}

/* 
 * ChatMemberInfoComponentUninitialized is the uninitialized state of the ChatMemberInfoComponentBloc 
 */
class ChatMemberInfoComponentUninitialized
    extends ChatMemberInfoComponentState {}

/* 
 * ChatMemberInfoComponentError is the error state of the ChatMemberInfoComponentBloc 
 */
class ChatMemberInfoComponentError extends ChatMemberInfoComponentState {
  final String? message;
  ChatMemberInfoComponentError({this.message});
}

/* 
 * ChatMemberInfoComponentPermissionDenied is to indicate permission denied state of the ChatMemberInfoComponentBloc 
 */
class ChatMemberInfoComponentPermissionDenied
    extends ChatMemberInfoComponentState {
  ChatMemberInfoComponentPermissionDenied();
}

/* 
 * ChatMemberInfoComponentLoaded is used to set the state of the ChatMemberInfoComponentBloc to the loaded state
 */
class ChatMemberInfoComponentLoaded extends ChatMemberInfoComponentState {
  final ChatMemberInfoModel value;

  /* 
   * construct ChatMemberInfoComponentLoaded
   */
  const ChatMemberInfoComponentLoaded({required this.value});

  /* 
   * copy method
   */
  ChatMemberInfoComponentLoaded copyWith({ChatMemberInfoModel? copyThis}) {
    return ChatMemberInfoComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChatMemberInfoComponentLoaded { value: $value }';
}
