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

abstract class ChatDashboardComponentState extends Equatable {
  const ChatDashboardComponentState();

  @override
  List<Object?> get props => [];
}

class ChatDashboardComponentUninitialized extends ChatDashboardComponentState {}

class ChatDashboardComponentError extends ChatDashboardComponentState {
  final String? message;
  ChatDashboardComponentError({ this.message });
}

class ChatDashboardComponentPermissionDenied extends ChatDashboardComponentState {
  ChatDashboardComponentPermissionDenied();
}

class ChatDashboardComponentLoaded extends ChatDashboardComponentState {
  final ChatDashboardModel value;

  const ChatDashboardComponentLoaded({ required this.value });

  ChatDashboardComponentLoaded copyWith({ ChatDashboardModel? copyThis }) {
    return ChatDashboardComponentLoaded(value: copyThis ?? this.value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ChatDashboardComponentLoaded { value: $value }';
}

