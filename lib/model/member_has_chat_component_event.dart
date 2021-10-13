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

abstract class MemberHasChatComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMemberHasChatComponent extends MemberHasChatComponentEvent {
  final String? id;

  FetchMemberHasChatComponent({ this.id });
}

class MemberHasChatComponentUpdated extends MemberHasChatComponentEvent {
  final MemberHasChatModel value;

  MemberHasChatComponentUpdated({ required this.value });
}


