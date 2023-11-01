/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';


@immutable
abstract class ChatMediumFormEvent extends Equatable {
  const ChatMediumFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewChatMediumFormEvent extends ChatMediumFormEvent {
}


class InitialiseChatMediumFormEvent extends ChatMediumFormEvent {
  final ChatMediumModel? value;

  @override
  List<Object?> get props => [ value ];

  const InitialiseChatMediumFormEvent({this.value});
}

class InitialiseChatMediumFormNoLoadEvent extends ChatMediumFormEvent {
  final ChatMediumModel? value;

  @override
  List<Object?> get props => [ value ];

  const InitialiseChatMediumFormNoLoadEvent({this.value});
}

class ChangedChatMediumDocumentID extends ChatMediumFormEvent {
  final String? value;

  const ChangedChatMediumDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMediumDocumentID{ value: $value }';
}

class ChangedChatMediumMemberMedium extends ChatMediumFormEvent {
  final String? value;

  const ChangedChatMediumMemberMedium({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMediumMemberMedium{ value: $value }';
}

