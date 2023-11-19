/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';

/* 
 * ChatDashboardComponentState is the base class for state for ChatDashboardComponentBloc
 */
abstract class ChatDashboardComponentState extends Equatable {
  const ChatDashboardComponentState();

  @override
  List<Object?> get props => [];
}

/* 
 * ChatDashboardComponentUninitialized is the uninitialized state of the ChatDashboardComponentBloc 
 */
class ChatDashboardComponentUninitialized extends ChatDashboardComponentState {}

/* 
 * ChatDashboardComponentError is the error state of the ChatDashboardComponentBloc 
 */
class ChatDashboardComponentError extends ChatDashboardComponentState {
  final String? message;
  ChatDashboardComponentError({ this.message });
}

/* 
 * ChatDashboardComponentPermissionDenied is to indicate permission denied state of the ChatDashboardComponentBloc 
 */
class ChatDashboardComponentPermissionDenied extends ChatDashboardComponentState {
  ChatDashboardComponentPermissionDenied();
}

/* 
 * ChatDashboardComponentLoaded is used to set the state of the ChatDashboardComponentBloc to the loaded state
 */
class ChatDashboardComponentLoaded extends ChatDashboardComponentState {
  final ChatDashboardModel value;

  /* 
   * construct ChatDashboardComponentLoaded
   */
  const ChatDashboardComponentLoaded({ required this.value });

  /* 
   * copy method
   */
  ChatDashboardComponentLoaded copyWith({ ChatDashboardModel? copyThis }) {
    return ChatDashboardComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChatDashboardComponentLoaded { value: $value }';
}

