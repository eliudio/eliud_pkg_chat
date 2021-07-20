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

abstract class ChatMemberInfoComponentState extends Equatable {
  const ChatMemberInfoComponentState();

  @override
  List<Object?> get props => [];
}

class ChatMemberInfoComponentUninitialized extends ChatMemberInfoComponentState {}

class ChatMemberInfoComponentError extends ChatMemberInfoComponentState {
  final String? message;
  ChatMemberInfoComponentError({ this.message });
}

class ChatMemberInfoComponentPermissionDenied extends ChatMemberInfoComponentState {
  ChatMemberInfoComponentPermissionDenied();
}

class ChatMemberInfoComponentLoaded extends ChatMemberInfoComponentState {
  final ChatMemberInfoModel? value;

  const ChatMemberInfoComponentLoaded({ this.value });

  ChatMemberInfoComponentLoaded copyWith({ ChatMemberInfoModel? copyThis }) {
    return ChatMemberInfoComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChatMemberInfoComponentLoaded { value: $value }';
}

