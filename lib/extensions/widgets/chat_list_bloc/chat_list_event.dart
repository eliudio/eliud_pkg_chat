import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatList extends ChatListEvent {
  final RoomModel room;

  LoadChatList(this.room);
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
  final RoomModel room;
  final List<ChatModel?> value;
  final bool? mightHaveMore;

  const ChatListUpdated({ required this.room, required this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore, room ];

  @override
  String toString() => 'ChatListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

