/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';

/*
 * ChatComponentEvent is the base class for events to be used with constructing a ChatComponentBloc 
 */
abstract class ChatComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/*
 * FetchChatComponent is the event to instruct the bloc to fetch the component
 */
class FetchChatComponent extends ChatComponentEvent {
  final String? id;

  /*
   * Construct the FetchChatComponent
   */
  FetchChatComponent({this.id});
}

/*
 * ChatComponentUpdated is the event to inform the bloc that a component has been updated
 */
class ChatComponentUpdated extends ChatComponentEvent {
  final ChatModel value;

  /*
   * Construct the ChatComponentUpdated
   */
  ChatComponentUpdated({required this.value});
}
