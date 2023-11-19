/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_model/tools/query/query_tools.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

abstract class RoomListEvent extends Equatable {
  const RoomListEvent();
  @override
  List<Object?> get props => [];
}

class LoadRoomList extends RoomListEvent {}

class NewPage extends RoomListEvent {}

class AddRoomList extends RoomListEvent {
  final RoomModel? value;

  const AddRoomList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddRoomList{ value: $value }';
}

class UpdateRoomList extends RoomListEvent {
  final RoomModel? value;

  const UpdateRoomList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateRoomList{ value: $value }';
}

class DeleteRoomList extends RoomListEvent {
  final RoomModel? value;

  const DeleteRoomList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteRoomList{ value: $value }';
}

class RoomListUpdated extends RoomListEvent {
  final List<RoomModel?>? value;
  final bool? mightHaveMore;

  const RoomListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'RoomListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

class RoomChangeQuery extends RoomListEvent {
  final EliudQuery? newQuery;

  const RoomChangeQuery({ required this.newQuery });

  @override
  List<Object?> get props => [ newQuery ];

  @override
  String toString() => 'RoomChangeQuery{ value: $newQuery }';
}

