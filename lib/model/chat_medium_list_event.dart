/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';

abstract class ChatMediumListEvent extends Equatable {
  const ChatMediumListEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatMediumList extends ChatMediumListEvent {}

class NewPage extends ChatMediumListEvent {}

class AddChatMediumList extends ChatMediumListEvent {
  final ChatMediumModel? value;

  const AddChatMediumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddChatMediumList{ value: $value }';
}

class UpdateChatMediumList extends ChatMediumListEvent {
  final ChatMediumModel? value;

  const UpdateChatMediumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateChatMediumList{ value: $value }';
}

class DeleteChatMediumList extends ChatMediumListEvent {
  final ChatMediumModel? value;

  const DeleteChatMediumList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteChatMediumList{ value: $value }';
}

class ChatMediumListUpdated extends ChatMediumListEvent {
  final List<ChatMediumModel?>? value;
  final bool? mightHaveMore;

  const ChatMediumListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'ChatMediumListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

