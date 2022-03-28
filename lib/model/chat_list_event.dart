/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatList extends ChatListEvent {}

class NewPage extends ChatListEvent {}

class AddChatList extends ChatListEvent {
  final ChatModel? value;

  const AddChatList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddChatList{ value: $value }';
}

class UpdateChatList extends ChatListEvent {
  final ChatModel? value;

  const UpdateChatList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateChatList{ value: $value }';
}

class DeleteChatList extends ChatListEvent {
  final ChatModel? value;

  const DeleteChatList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteChatList{ value: $value }';
}

class ChatListUpdated extends ChatListEvent {
  final List<ChatModel?>? value;
  final bool? mightHaveMore;

  const ChatListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'ChatListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

class ChatChangeQuery extends ChatListEvent {
  final EliudQuery newQuery;

  const ChatChangeQuery({ required this.newQuery });

  @override
  List<Object?> get props => [ newQuery ];

  @override
  String toString() => 'ChatChangeQuery{ value: $newQuery }';
}

