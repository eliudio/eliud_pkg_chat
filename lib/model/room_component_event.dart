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


/*
 * RoomComponentEvent is the base class for events to be used with constructing a RoomComponentBloc 
 */
abstract class RoomComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/*
 * FetchRoomComponent is the event to instruct the bloc to fetch the component
 */
class FetchRoomComponent extends RoomComponentEvent {
  final String? id;

  /*
   * Construct the FetchRoomComponent
   */
  FetchRoomComponent({ this.id });
}

/*
 * RoomComponentUpdated is the event to inform the bloc that a component has been updated
 */
class RoomComponentUpdated extends RoomComponentEvent {
  final RoomModel value;

  /*
   * Construct the RoomComponentUpdated
   */
  RoomComponentUpdated({ required this.value });
}


