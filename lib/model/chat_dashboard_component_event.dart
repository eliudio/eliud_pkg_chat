/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';


/*
 * ChatDashboardComponentEvent is the base class for events to be used with constructing a ChatDashboardComponentBloc 
 */
abstract class ChatDashboardComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/*
 * FetchChatDashboardComponent is the event to instruct the bloc to fetch the component
 */
class FetchChatDashboardComponent extends ChatDashboardComponentEvent {
  final String? id;

  /*
   * Construct the FetchChatDashboardComponent
   */
  FetchChatDashboardComponent({ this.id });
}

/*
 * ChatDashboardComponentUpdated is the event to inform the bloc that a component has been updated
 */
class ChatDashboardComponentUpdated extends ChatDashboardComponentEvent {
  final ChatDashboardModel value;

  /*
   * Construct the ChatDashboardComponentUpdated
   */
  ChatDashboardComponentUpdated({ required this.value });
}


