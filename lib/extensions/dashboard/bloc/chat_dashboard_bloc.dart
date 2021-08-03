import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/extensions/chat/chat.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/cupertino.dart';
import '../../chat_dashboard_component.dart';
import 'chat_dashboard_event.dart';
import 'chat_dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDashboardBloc extends Bloc<ChatDashboardEvent, ChatDashboardState> {
  final String appId;

  ChatDashboardBloc(this.appId) : super(ChatDashboardStateUninitialized());

  @override
  Stream<ChatDashboardState> mapEventToState(ChatDashboardEvent event) async* {
    if (event is OpenMemberRoomsWidgetEvent) {
      yield MemberRoomsWidgetState();
    }
  }

  static void openRoom(BuildContext context, RoomModel value, String currentMemberId) {
    StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .dialogStyle()
        .openFlexibleDialog(context,
        title: 'Chat',
        child: ChatPage(
          room: value,
          memberId: currentMemberId,
          roomId: value.documentID!,
          members: value.members!,
          height: MediaQuery.of(context).size.height -
              ChatDashboard.HEADER_HEIGHT,
          appId: value.appId!,
        ),
        buttons: [
          StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .buttonStyle()
              .dialogButton(context,
              label: 'Close',
              onPressed: () => Navigator.of(context).pop()),
        ]);
  }


}
