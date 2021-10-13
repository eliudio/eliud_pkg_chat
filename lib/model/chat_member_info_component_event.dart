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

abstract class ChatMemberInfoComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchChatMemberInfoComponent extends ChatMemberInfoComponentEvent {
  final String? id;

  FetchChatMemberInfoComponent({ this.id });
}

class ChatMemberInfoComponentUpdated extends ChatMemberInfoComponentEvent {
  final ChatMemberInfoModel value;

  ChatMemberInfoComponentUpdated({ required this.value });
}


