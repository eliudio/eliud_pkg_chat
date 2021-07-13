/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

abstract class RoomComponentState extends Equatable {
  const RoomComponentState();

  @override
  List<Object?> get props => [];
}

class RoomComponentUninitialized extends RoomComponentState {}

class RoomComponentError extends RoomComponentState {
  final String? message;
  RoomComponentError({ this.message });
}

class RoomComponentPermissionDenied extends RoomComponentState {
  RoomComponentPermissionDenied();
}

class RoomComponentLoaded extends RoomComponentState {
  final RoomModel? value;

  const RoomComponentLoaded({ this.value });

  RoomComponentLoaded copyWith({ RoomModel? copyThis }) {
    return RoomComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'RoomComponentLoaded { value: $value }';
}

