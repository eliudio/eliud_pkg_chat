/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_form_event.dart
                       
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
abstract class ChatInteractionsFormEvent extends Equatable {
  const ChatInteractionsFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewChatInteractionsFormEvent extends ChatInteractionsFormEvent {
}


class InitialiseChatInteractionsFormEvent extends ChatInteractionsFormEvent {
  final ChatInteractionsModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseChatInteractionsFormEvent({this.value});
}

class InitialiseChatInteractionsFormNoLoadEvent extends ChatInteractionsFormEvent {
  final ChatInteractionsModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseChatInteractionsFormNoLoadEvent({this.value});
}

class ChangedChatInteractionsDocumentID extends ChatInteractionsFormEvent {
  final String? value;

  ChangedChatInteractionsDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatInteractionsDocumentID{ value: $value }';
}

class ChangedChatInteractionsAuthorId extends ChatInteractionsFormEvent {
  final String? value;

  ChangedChatInteractionsAuthorId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatInteractionsAuthorId{ value: $value }';
}

class ChangedChatInteractionsAppId extends ChatInteractionsFormEvent {
  final String? value;

  ChangedChatInteractionsAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatInteractionsAppId{ value: $value }';
}

class ChangedChatInteractionsDetails extends ChatInteractionsFormEvent {
  final String? value;

  ChangedChatInteractionsDetails({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatInteractionsDetails{ value: $value }';
}

class ChangedChatInteractionsReadAccess extends ChatInteractionsFormEvent {
  final String? value;

  ChangedChatInteractionsReadAccess({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedChatInteractionsReadAccess{ value: $value }';
}

