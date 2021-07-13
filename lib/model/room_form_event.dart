/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_form_event.dart
                       
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
abstract class RoomFormEvent extends Equatable {
  const RoomFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialiseNewRoomFormEvent extends RoomFormEvent {
}


class InitialiseRoomFormEvent extends RoomFormEvent {
  final RoomModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseRoomFormEvent({this.value});
}

class InitialiseRoomFormNoLoadEvent extends RoomFormEvent {
  final RoomModel? value;

  @override
  List<Object?> get props => [ value ];

  InitialiseRoomFormNoLoadEvent({this.value});
}

class ChangedRoomDocumentID extends RoomFormEvent {
  final String? value;

  ChangedRoomDocumentID({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedRoomDocumentID{ value: $value }';
}

class ChangedRoomOwnerId extends RoomFormEvent {
  final String? value;

  ChangedRoomOwnerId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedRoomOwnerId{ value: $value }';
}

class ChangedRoomAppId extends RoomFormEvent {
  final String? value;

  ChangedRoomAppId({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedRoomAppId{ value: $value }';
}

class ChangedRoomDescription extends RoomFormEvent {
  final String? value;

  ChangedRoomDescription({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedRoomDescription{ value: $value }';
}

class ChangedRoomMembers extends RoomFormEvent {
  final String? value;

  ChangedRoomMembers({this.value});

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'ChangedRoomMembers{ value: $value }';
}

