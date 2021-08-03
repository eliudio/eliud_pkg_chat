import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
abstract class ChatDashboardState extends Equatable {
  const ChatDashboardState();

  @override
  List<Object?> get props => [];
}

class ChatDashboardError extends ChatDashboardState {
  final String message;

  ChatDashboardError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is ChatDashboardError &&
          runtimeType == other.runtimeType &&
          message == other.message;
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ChatDashboardStateUninitialized extends ChatDashboardState {
  @override
  String toString() {
    return '''ChatDashboardStateUninitialized()''';
  }

  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is ChatDashboardStateUninitialized && runtimeType == other.runtimeType;
}

// MemberRoomsWidgetState: List all members and allow to open a chat with one of these members, i.e. MembersWidget!
class MemberRoomsWidgetState extends ChatDashboardState {
  // nothing
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MemberRoomsWidgetState &&
              runtimeType == other.runtimeType;
}

/*
// RealRoomFormsWidgetState: open a form to create a room!
class RealRoomFormsWidgetState extends ChatDashboardState {
  // nothing
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is RealRoomFormsWidgetState &&
              runtimeType == other.runtimeType;
}

// ExistingRealRoomsWidgetState: List all rooms which are real roonms, i.e. RoomWidget. Allow to open the chat (send the OpenChatWidget event)!
class ExistingRealRoomsWidgetState extends ChatDashboardState {
  // nothing
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ExistingRealRoomsWidgetState &&
              runtimeType == other.runtimeType;
}

// Open the chat!
class ChatWidgetState extends ChatDashboardState {
  final RoomModel room;
  final int selectedOptionBeforeChat;

  const ChatWidgetState(this.room, this.selectedOptionBeforeChat);

  @override
  List<Object?> get props => [room, selectedOptionBeforeChat];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ChatWidgetState &&
          runtimeType == other.runtimeType &&
          room == other.room &&
          selectedOptionBeforeChat == other.selectedOptionBeforeChat;
}
*/
