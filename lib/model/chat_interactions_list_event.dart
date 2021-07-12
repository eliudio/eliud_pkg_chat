/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_model.dart';

abstract class ChatInteractionsListEvent extends Equatable {
  const ChatInteractionsListEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatInteractionsList extends ChatInteractionsListEvent {}

class NewPage extends ChatInteractionsListEvent {}

class AddChatInteractionsList extends ChatInteractionsListEvent {
  final ChatInteractionsModel? value;

  const AddChatInteractionsList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddChatInteractionsList{ value: $value }';
}

class UpdateChatInteractionsList extends ChatInteractionsListEvent {
  final ChatInteractionsModel? value;

  const UpdateChatInteractionsList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateChatInteractionsList{ value: $value }';
}

class DeleteChatInteractionsList extends ChatInteractionsListEvent {
  final ChatInteractionsModel? value;

  const DeleteChatInteractionsList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteChatInteractionsList{ value: $value }';
}

class ChatInteractionsListUpdated extends ChatInteractionsListEvent {
  final List<ChatInteractionsModel?>? value;
  final bool? mightHaveMore;

  const ChatInteractionsListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'ChatInteractionsListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

