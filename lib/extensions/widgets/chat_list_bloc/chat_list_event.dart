import 'package:eliud_pkg_chat/extensions/widgets/all_chats_bloc/all_chats_state.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();
  @override
  List<Object?> get props => [];
}

class SelectChatList extends ChatListEvent {
  final EnhancedRoomModel room;

  SelectChatList(this.room);
}

class NewChatPage extends ChatListEvent {
  final RoomModel room;

  NewChatPage(this.room);
}

class AddChatList extends ChatListEvent {
  final ChatModel? value;

  const AddChatList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddChatList{ value: $value }';
}

class ChatListUpdated extends ChatListEvent {
  final EnhancedRoomModel room;
  final List<ChatModel> value;
  final bool? mightHaveMore;

  const ChatListUpdated({ required this.room, required this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore, room ];

  @override
  String toString() => 'ChatListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}


class UpdateEnhancedRoomModel extends ChatListEvent {
  final EnhancedRoomModel model;
  UpdateEnhancedRoomModel(this.model);
}

class MarkAsRead extends ChatListEvent {
  final EnhancedRoomModel enhancedRoomModel;
  final ChatModel chat;

  MarkAsRead(this.enhancedRoomModel, this.chat);
}