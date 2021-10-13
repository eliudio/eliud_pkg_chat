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

abstract class ChatComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchChatComponent extends ChatComponentEvent {
  final String? id;

  FetchChatComponent({ this.id });
}

class ChatComponentUpdated extends ChatComponentEvent {
  final ChatModel value;

  ChatComponentUpdated({ required this.value });
}


