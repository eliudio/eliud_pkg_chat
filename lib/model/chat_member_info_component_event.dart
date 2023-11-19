/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';


/*
 * ChatMemberInfoComponentEvent is the base class for events to be used with constructing a ChatMemberInfoComponentBloc 
 */
abstract class ChatMemberInfoComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/*
 * FetchChatMemberInfoComponent is the event to instruct the bloc to fetch the component
 */
class FetchChatMemberInfoComponent extends ChatMemberInfoComponentEvent {
  final String? id;

  /*
   * Construct the FetchChatMemberInfoComponent
   */
  FetchChatMemberInfoComponent({ this.id });
}

/*
 * ChatMemberInfoComponentUpdated is the event to inform the bloc that a component has been updated
 */
class ChatMemberInfoComponentUpdated extends ChatMemberInfoComponentEvent {
  final ChatMemberInfoModel value;

  /*
   * Construct the ChatMemberInfoComponentUpdated
   */
  ChatMemberInfoComponentUpdated({ required this.value });
}


