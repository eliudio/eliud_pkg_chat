/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_form_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

@immutable
abstract class MemberHasChatFormEvent extends Equatable {
  const MemberHasChatFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewMemberHasChatFormEvent extends MemberHasChatFormEvent {}

class InitialiseMemberHasChatFormEvent extends MemberHasChatFormEvent {
  final MemberHasChatModel? value;

  @override
  List<Object?> get props => [value];

  InitialiseMemberHasChatFormEvent({this.value});
}

class InitialiseMemberHasChatFormNoLoadEvent extends MemberHasChatFormEvent {
  final MemberHasChatModel? value;

  @override
  List<Object?> get props => [value];

  InitialiseMemberHasChatFormNoLoadEvent({this.value});
}

class ChangedMemberHasChatDocumentID extends MemberHasChatFormEvent {
  final String? value;

  ChangedMemberHasChatDocumentID({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedMemberHasChatDocumentID{ value: $value }';
}

class ChangedMemberHasChatMemberId extends MemberHasChatFormEvent {
  final String? value;

  ChangedMemberHasChatMemberId({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedMemberHasChatMemberId{ value: $value }';
}

class ChangedMemberHasChatAppId extends MemberHasChatFormEvent {
  final String? value;

  ChangedMemberHasChatAppId({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedMemberHasChatAppId{ value: $value }';
}

class ChangedMemberHasChatHasUnread extends MemberHasChatFormEvent {
  final bool? value;

  ChangedMemberHasChatHasUnread({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChangedMemberHasChatHasUnread{ value: $value }';
}
