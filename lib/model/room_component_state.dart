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

/* 
 * RoomComponentState is the base class for state for RoomComponentBloc
 */
abstract class RoomComponentState extends Equatable {
  const RoomComponentState();

  @override
  List<Object?> get props => [];
}

/* 
 * RoomComponentUninitialized is the uninitialized state of the RoomComponentBloc 
 */
class RoomComponentUninitialized extends RoomComponentState {}

/* 
 * RoomComponentError is the error state of the RoomComponentBloc 
 */
class RoomComponentError extends RoomComponentState {
  final String? message;
  RoomComponentError({ this.message });
}

/* 
 * RoomComponentPermissionDenied is to indicate permission denied state of the RoomComponentBloc 
 */
class RoomComponentPermissionDenied extends RoomComponentState {
  RoomComponentPermissionDenied();
}

/* 
 * RoomComponentLoaded is used to set the state of the RoomComponentBloc to the loaded state
 */
class RoomComponentLoaded extends RoomComponentState {
  final RoomModel value;

  /* 
   * construct RoomComponentLoaded
   */
  const RoomComponentLoaded({ required this.value });

  /* 
   * copy method
   */
  RoomComponentLoaded copyWith({ RoomModel? copyThis }) {
    return RoomComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'RoomComponentLoaded { value: $value }';
}

