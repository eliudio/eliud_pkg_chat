import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is ChatError &&
          runtimeType == other.runtimeType &&
          message == other.message;
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ChatStateUninitialized extends ChatState {
  @override
  String toString() {
    return '''ChatStateUninitialized()''';
  }

  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is ChatStateUninitialized && runtimeType == other.runtimeType;
}

// UnreadWidgetState: List the items in unread
class UnreadWidgetState extends ChatState {
  // list of unread items
  // this is determined by _chatMemberInfoRepository which holds the last read entry per member, per room
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is UnreadWidgetState &&
              runtimeType == other.runtimeType;
}

// MemberRoomsWidgetState: List all members and allow to open a chat with one of these members, i.e. MembersWidget
class MemberRoomsWidgetState extends ChatState {
  // nothing
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MemberRoomsWidgetState &&
              runtimeType == other.runtimeType;
}

// RealRoomFormsWidgetState: open a form to create a room
class RealRoomFormsWidgetState extends ChatState {
  // nothing
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is RealRoomFormsWidgetState &&
              runtimeType == other.runtimeType;
}

// ExistingMemberRoomsWidgetState: List all rooms which are not real roonms, i.e. RoomWidget with isRoom = false
class ExistingMemberRoomsWidgetState extends ChatState {
  // nothing
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ExistingMemberRoomsWidgetState &&
              runtimeType == other.runtimeType;
}

// ExistingRealRoomsWidgetState: List all rooms which are real roonms, i.e. RoomWidget. Allow to open the chat (send the OpenChatWidget event)
class ExistingRealRoomsWidgetState extends ChatState {
  // nothing
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ExistingRealRoomsWidgetState &&
              runtimeType == other.runtimeType;
}

class ChatWidgetState extends ChatState {
  final RoomModel room;

  ChatWidgetState(this.room);

  @override
  List<Object?> get props => [room];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ChatWidgetState &&
          runtimeType == other.runtimeType &&
          room == other.room;
}

// there might be ChatWidgetState subclasses