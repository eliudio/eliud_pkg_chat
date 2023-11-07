/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

abstract class RoomComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRoomComponent extends RoomComponentEvent {
  final String? id;

  FetchRoomComponent({this.id});
}

class RoomComponentUpdated extends RoomComponentEvent {
  final RoomModel value;

  RoomComponentUpdated({required this.value});
}
