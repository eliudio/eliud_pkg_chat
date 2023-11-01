/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';


@immutable
abstract class ChatMemberInfoFormEvent extends Equatable {
  const ChatMemberInfoFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewChatMemberInfoFormEvent extends ChatMemberInfoFormEvent {
}


class InitialiseChatMemberInfoFormEvent extends ChatMemberInfoFormEvent {
  final ChatMemberInfoModel? value;

  @override
  List<Object?> get props => [ value ];

  const InitialiseChatMemberInfoFormEvent({this.value});
}

class InitialiseChatMemberInfoFormNoLoadEvent extends ChatMemberInfoFormEvent {
  final ChatMemberInfoModel? value;

  @override
  List<Object?> get props => [ value ];

  const InitialiseChatMemberInfoFormNoLoadEvent({this.value});
}

class ChangedChatMemberInfoDocumentID extends ChatMemberInfoFormEvent {
  final String? value;

  const ChangedChatMemberInfoDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoDocumentID{ value: $value }';
}

class ChangedChatMemberInfoAuthorId extends ChatMemberInfoFormEvent {
  final String? value;

  const ChangedChatMemberInfoAuthorId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoAuthorId{ value: $value }';
}

class ChangedChatMemberInfoAppId extends ChatMemberInfoFormEvent {
  final String? value;

  const ChangedChatMemberInfoAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoAppId{ value: $value }';
}

class ChangedChatMemberInfoRoomId extends ChatMemberInfoFormEvent {
  final String? value;

  const ChangedChatMemberInfoRoomId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoRoomId{ value: $value }';
}

class ChangedChatMemberInfoTimestamp extends ChatMemberInfoFormEvent {
  final String? value;

  const ChangedChatMemberInfoTimestamp({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoTimestamp{ value: $value }';
}

class ChangedChatMemberInfoAccessibleByGroup extends ChatMemberInfoFormEvent {
  final ChatMemberInfoAccessibleByGroup? value;

  const ChangedChatMemberInfoAccessibleByGroup({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoAccessibleByGroup{ value: $value }';
}

class ChangedChatMemberInfoAccessibleByMembers extends ChatMemberInfoFormEvent {
  final String? value;

  const ChangedChatMemberInfoAccessibleByMembers({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoAccessibleByMembers{ value: $value }';
}

class ChangedChatMemberInfoReadAccess extends ChatMemberInfoFormEvent {
  final String? value;

  const ChangedChatMemberInfoReadAccess({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoReadAccess{ value: $value }';
}

