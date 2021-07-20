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
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


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

  InitialiseChatMemberInfoFormEvent({this.value});
}

class InitialiseChatMemberInfoFormNoLoadEvent extends ChatMemberInfoFormEvent {
  final ChatMemberInfoModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseChatMemberInfoFormNoLoadEvent({this.value});
}

class ChangedChatMemberInfoDocumentID extends ChatMemberInfoFormEvent {
  final String? value;

  ChangedChatMemberInfoDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoDocumentID{ value: $value }';
}

class ChangedChatMemberInfoMemberId extends ChatMemberInfoFormEvent {
  final String? value;

  ChangedChatMemberInfoMemberId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoMemberId{ value: $value }';
}

class ChangedChatMemberInfoRoomId extends ChatMemberInfoFormEvent {
  final String? value;

  ChangedChatMemberInfoRoomId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoRoomId{ value: $value }';
}

class ChangedChatMemberInfoTimestamp extends ChatMemberInfoFormEvent {
  final String? value;

  ChangedChatMemberInfoTimestamp({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMemberInfoTimestamp{ value: $value }';
}

