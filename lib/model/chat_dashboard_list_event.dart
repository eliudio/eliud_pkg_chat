/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';

abstract class ChatDashboardListEvent extends Equatable {
  const ChatDashboardListEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatDashboardList extends ChatDashboardListEvent {}

class NewPage extends ChatDashboardListEvent {}

class AddChatDashboardList extends ChatDashboardListEvent {
  final ChatDashboardModel? value;

  const AddChatDashboardList({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'AddChatDashboardList{ value: $value }';
}

class UpdateChatDashboardList extends ChatDashboardListEvent {
  final ChatDashboardModel? value;

  const UpdateChatDashboardList({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'UpdateChatDashboardList{ value: $value }';
}

class DeleteChatDashboardList extends ChatDashboardListEvent {
  final ChatDashboardModel? value;

  const DeleteChatDashboardList({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'DeleteChatDashboardList{ value: $value }';
}

class ChatDashboardListUpdated extends ChatDashboardListEvent {
  final List<ChatDashboardModel?>? value;
  final bool? mightHaveMore;

  const ChatDashboardListUpdated({this.value, this.mightHaveMore});

  @override
  List<Object?> get props => [value, mightHaveMore];

  @override
  String toString() =>
      'ChatDashboardListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

class ChatDashboardChangeQuery extends ChatDashboardListEvent {
  final EliudQuery? newQuery;

  const ChatDashboardChangeQuery({required this.newQuery});

  @override
  List<Object?> get props => [newQuery];

  @override
  String toString() => 'ChatDashboardChangeQuery{ value: $newQuery }';
}
