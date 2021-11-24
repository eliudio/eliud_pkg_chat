import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
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
    openFlexibleDialog(context, value.appId! + '/room',
        title: value.members!.length == 2 ? 'Chat' : 'Chatroom',
        child: ChatPage(
          roomId: value.documentID!,
          appId: value.appId!,
          memberId: currentMemberId,
          height: MediaQuery.of(context).size.height -
              ChatDashboard.HEADER_HEIGHT,
        ),
        buttons: [
          dialogButton(context,
              label: 'Close',
              onPressed: () => Navigator.of(context).pop()),
        ]);
  }


}
