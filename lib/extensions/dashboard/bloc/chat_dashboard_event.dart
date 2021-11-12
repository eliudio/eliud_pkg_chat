import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatDashboardEvent extends Equatable {
  const ChatDashboardEvent();

  @override
  List<Object?> get props => [];
}

class OpenMemberRoomsWidgetEvent extends ChatDashboardEvent {
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is OpenMemberRoomsWidgetEvent &&
              runtimeType == other.runtimeType;
}

/*
class OpenRealRoomFormsWidgetEvent extends ChatDashboardEvent {
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is OpenRealRoomFormsWidgetEvent &&
              runtimeType == other.runtimeType;
}

class OpenExistingRealRoomsWidgetEvent extends ChatDashboardEvent {
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is OpenExistingRealRoomsWidgetEvent &&
              runtimeType == other.runtimeType;
}

abstract class ChatWidgetEvent extends ChatDashboardEvent {
  ChatWidgetEvent();
}

class CreateChatWithMemberEvent extends ChatWidgetEvent {
  final String currentMemberId;
  final String otherMemberId;
  final int selectedOptionBeforeChat;

  CreateChatWithMemberEvent(this.currentMemberId, this.otherMemberId, this.selectedOptionBeforeChat);

  @override
  List<Object?> get props => [currentMemberId, otherMemberId, selectedOptionBeforeChat];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is CreateChatWithMemberEvent &&
              currentMemberId == other.currentMemberId &&
              otherMemberId == other.otherMemberId &&
              selectedOptionBeforeChat == other.selectedOptionBeforeChat &&
              runtimeType == other.runtimeType;
}

class OpenRoomEvent extends ChatDashboardEvent {
  final RoomModel room;

  OpenRoomEvent(this.room);

  @override
  List<Object?> get props => [room];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is OpenRoomEvent &&
              room == other.room &&
              runtimeType == other.runtimeType;
}*/
