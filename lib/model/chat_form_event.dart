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

  InitialiseChatFormEvent({this.value});
}

class InitialiseChatFormNoLoadEvent extends ChatFormEvent {
  final ChatModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseChatFormNoLoadEvent({this.value});
}

class ChangedChatDocumentID extends ChatFormEvent {
  final String? value;

  ChangedChatDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatDocumentID{ value: $value }';
}

class ChangedChatAppId extends ChatFormEvent {
  final String? value;

  ChangedChatAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatAppId{ value: $value }';
}

class ChangedChatDescription extends ChatFormEvent {
  final String? value;

  ChangedChatDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatDescription{ value: $value }';
}

class ChangedChatConditions extends ChatFormEvent {
  final ConditionsSimpleModel? value;

  ChangedChatConditions({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatConditions{ value: $value }';
}

