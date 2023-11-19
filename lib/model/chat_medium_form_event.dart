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
import 'package:eliud_core_model/tools/common_tools.dart';
import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


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

  InitialiseChatMediumFormEvent({this.value});
}

class InitialiseChatMediumFormNoLoadEvent extends ChatMediumFormEvent {
  final ChatMediumModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseChatMediumFormNoLoadEvent({this.value});
}

class ChangedChatMediumDocumentID extends ChatMediumFormEvent {
  final String? value;

  ChangedChatMediumDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMediumDocumentID{ value: $value }';
}

class ChangedChatMediumMemberMedium extends ChatMediumFormEvent {
  final String? value;

  ChangedChatMediumMemberMedium({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatMediumMemberMedium{ value: $value }';
}

