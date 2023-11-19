/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_model.dart';


/*
 * MemberHasChatComponentEvent is the base class for events to be used with constructing a MemberHasChatComponentBloc 
 */
abstract class MemberHasChatComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/*
 * FetchMemberHasChatComponent is the event to instruct the bloc to fetch the component
 */
class FetchMemberHasChatComponent extends MemberHasChatComponentEvent {
  final String? id;

  /*
   * Construct the FetchMemberHasChatComponent
   */
  FetchMemberHasChatComponent({ this.id });
}

/*
 * MemberHasChatComponentUpdated is the event to inform the bloc that a component has been updated
 */
class MemberHasChatComponentUpdated extends MemberHasChatComponentEvent {
  final MemberHasChatModel value;

  /*
   * Construct the MemberHasChatComponentUpdated
   */
  MemberHasChatComponentUpdated({ required this.value });
}


