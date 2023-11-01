/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';


@immutable
abstract class ChatFormEvent extends Equatable {
  const ChatFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewChatFormEvent extends ChatFormEvent {
}


class InitialiseChatFormEvent extends ChatFormEvent {
  final ChatModel? value;

  @override
  List<Object?> get props => [ value ];

  const InitialiseChatFormEvent({this.value});
}

class InitialiseChatFormNoLoadEvent extends ChatFormEvent {
  final ChatModel? value;

  @override
  List<Object?> get props => [ value ];

  const InitialiseChatFormNoLoadEvent({this.value});
}

class ChangedChatDocumentID extends ChatFormEvent {
  final String? value;

  const ChangedChatDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatDocumentID{ value: $value }';
}

class ChangedChatAuthorId extends ChatFormEvent {
  final String? value;

  const ChangedChatAuthorId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatAuthorId{ value: $value }';
}

class ChangedChatAppId extends ChatFormEvent {
  final String? value;

  const ChangedChatAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatAppId{ value: $value }';
}

class ChangedChatRoomId extends ChatFormEvent {
  final String? value;

  const ChangedChatRoomId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatRoomId{ value: $value }';
}

class ChangedChatTimestamp extends ChatFormEvent {
  final String? value;

  const ChangedChatTimestamp({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatTimestamp{ value: $value }';
}

class ChangedChatSaying extends ChatFormEvent {
  final String? value;

  const ChangedChatSaying({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatSaying{ value: $value }';
}

class ChangedChatAccessibleByGroup extends ChatFormEvent {
  final ChatAccessibleByGroup? value;

  const ChangedChatAccessibleByGroup({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatAccessibleByGroup{ value: $value }';
}

class ChangedChatAccessibleByMembers extends ChatFormEvent {
  final String? value;

  const ChangedChatAccessibleByMembers({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatAccessibleByMembers{ value: $value }';
}

class ChangedChatReadAccess extends ChatFormEvent {
  final String? value;

  const ChangedChatReadAccess({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatReadAccess{ value: $value }';
}

class ChangedChatChatMedia extends ChatFormEvent {
  final List<ChatMediumModel>? value;

  const ChangedChatChatMedia({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatChatMedia{ value: $value }';
}

