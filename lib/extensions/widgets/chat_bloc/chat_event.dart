import 'package:eliud_pkg_chat/extensions/widgets/all_chats_bloc/all_chats_state.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class OpenChatWithAMemberEvent extends ChatEvent {
  final String otherMember;

  const OpenChatWithAMemberEvent(this.otherMember);
}

class OpenChatWithMembersEvent extends ChatEvent {
  final List<String> members;

  const OpenChatWithMembersEvent(this.members);
}

class SelectChatEvent extends ChatEvent {
  final EnhancedRoomModel room;

  const SelectChatEvent(this.room);
}

class NewChatPage extends ChatEvent {
  final RoomModel room;

  const NewChatPage(this.room);
}

class AddChat extends ChatEvent {
  final ChatModel? value;

  const AddChat({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'AddChat{ value: $value }';
}

class ChatUpdated extends ChatEvent {
  final EnhancedRoomModel room;
  final List<ChatModel> value;
  final bool? mightHaveMore;

  const ChatUpdated(
      {required this.room, required this.value, this.mightHaveMore});

  @override
  List<Object?> get props => [value, mightHaveMore, room];

  @override
  String toString() =>
      'ChatUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

class UpdateEnhancedRoomModel extends ChatEvent {
  final EnhancedRoomModel model;
  const UpdateEnhancedRoomModel(this.model);
}

class MarkAsRead extends ChatEvent {
  final EnhancedRoomModel enhancedRoomModel;
  final ChatModel chat;

  const MarkAsRead(this.enhancedRoomModel, this.chat);
}
