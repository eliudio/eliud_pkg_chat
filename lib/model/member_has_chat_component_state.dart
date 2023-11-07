/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_model.dart';

abstract class MemberHasChatComponentState extends Equatable {
  const MemberHasChatComponentState();

  @override
  List<Object?> get props => [];
}

class MemberHasChatComponentUninitialized extends MemberHasChatComponentState {}

class MemberHasChatComponentError extends MemberHasChatComponentState {
  final String? message;
  MemberHasChatComponentError({this.message});
}

class MemberHasChatComponentPermissionDenied
    extends MemberHasChatComponentState {
  MemberHasChatComponentPermissionDenied();
}

class MemberHasChatComponentLoaded extends MemberHasChatComponentState {
  final MemberHasChatModel value;

  const MemberHasChatComponentLoaded({required this.value});

  MemberHasChatComponentLoaded copyWith({MemberHasChatModel? copyThis}) {
    return MemberHasChatComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'MemberHasChatComponentLoaded { value: $value }';
}
