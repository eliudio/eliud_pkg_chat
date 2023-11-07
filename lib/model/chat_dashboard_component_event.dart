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

abstract class ChatDashboardComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchChatDashboardComponent extends ChatDashboardComponentEvent {
  final String? id;

  FetchChatDashboardComponent({this.id});
}

class ChatDashboardComponentUpdated extends ChatDashboardComponentEvent {
  final ChatDashboardModel value;

  ChatDashboardComponentUpdated({required this.value});
}
