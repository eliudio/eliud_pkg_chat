import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatDashboardEvent extends Equatable {
  const ChatDashboardEvent();

  @override
  List<Object?> get props => [];
}

class OpenUnreadWidgetEvent extends ChatDashboardEvent {
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is OpenUnreadWidgetEvent &&
              runtimeType == other.runtimeType;
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

class OpenRealRoomFormsWidgetEvent extends ChatDashboardEvent {
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is OpenRealRoomFormsWidgetEvent &&
              runtimeType == other.runtimeType;
}

class OpenExistingMemberRoomsWidgetEvent extends ChatDashboardEvent {
  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is OpenExistingMemberRoomsWidgetEvent &&
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

  CreateChatWithMemberEvent(this.currentMemberId, this.otherMemberId);

  @override
  List<Object?> get props => [];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is CreateChatWithMemberEvent &&
              runtimeType == other.runtimeType;
}