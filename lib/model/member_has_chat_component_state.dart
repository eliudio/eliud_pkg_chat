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

/* 
 * MemberHasChatComponentState is the base class for state for MemberHasChatComponentBloc
 */
abstract class MemberHasChatComponentState extends Equatable {
  const MemberHasChatComponentState();

  @override
  List<Object?> get props => [];
}

/* 
 * MemberHasChatComponentUninitialized is the uninitialized state of the MemberHasChatComponentBloc 
 */
class MemberHasChatComponentUninitialized extends MemberHasChatComponentState {}

/* 
 * MemberHasChatComponentError is the error state of the MemberHasChatComponentBloc 
 */
class MemberHasChatComponentError extends MemberHasChatComponentState {
  final String? message;
  MemberHasChatComponentError({this.message});
}

/* 
 * MemberHasChatComponentPermissionDenied is to indicate permission denied state of the MemberHasChatComponentBloc 
 */
class MemberHasChatComponentPermissionDenied
    extends MemberHasChatComponentState {
  MemberHasChatComponentPermissionDenied();
}

/* 
 * MemberHasChatComponentLoaded is used to set the state of the MemberHasChatComponentBloc to the loaded state
 */
class MemberHasChatComponentLoaded extends MemberHasChatComponentState {
  final MemberHasChatModel value;

  /* 
   * construct MemberHasChatComponentLoaded
   */
  const MemberHasChatComponentLoaded({required this.value});

  /* 
   * copy method
   */
  MemberHasChatComponentLoaded copyWith({MemberHasChatModel? copyThis}) {
    return MemberHasChatComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'MemberHasChatComponentLoaded { value: $value }';
}
