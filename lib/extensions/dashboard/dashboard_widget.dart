import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/members_widget.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/room_widget.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import '../chat_dashboard_component.dart';

class DashboardWidget extends StatefulWidget {
  final String appId;
  final String memberId;

  const DashboardWidget({
    Key? key,
    required this.appId,
    required this.memberId,
  }) : super(key: key);

  @override
  DashboardWidgetState createState() => DashboardWidgetState(appId, memberId);
}

class DashboardWidgetState extends State<DashboardWidget>
    with SingleTickerProviderStateMixin {
  static double ICON_SIZE = 75;

  final String appId;
  final String memberId;

  DashboardWidgetState(this.appId, this.memberId);

  @override
  Widget build(BuildContext context) {
    var eliudQuery = EliudQuery()
        .withCondition(EliudQueryCondition('appId', isEqualTo: widget.appId))
        .withCondition(
        EliudQueryCondition('members', arrayContains: widget.memberId));
    return /*Stack(children: <Widget>[
      */SizedBox(
          height:
              MediaQuery.of(context).size.height - ChatDashboard.HEADER_HEIGHT,
          width: double.infinity,
          child: /*BlocBuilder<ChatDashboardBloc, ChatDashboardState>(
              builder: (context, state) {
                return */BlocProvider(
                    create: (_) => RoomListBloc(
                        orderBy: 'timestamp',
                        descending: true,
                        eliudQuery: eliudQuery,
                        roomRepository: roomRepository(appId: widget.appId)!)
                      ..add(LoadRoomList()),
                    child: RoomListWidget(appId: widget.appId, memberId: widget.memberId)));
    /*}))*/;
/*      Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3, color: Colors.black, spreadRadius: 2)
                    ],
                  ),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white, // border color
                      child: Image.asset("assets/images/cry-1636046_640.png",
                          package: "eliud_pkg_chat"))),
              onTap: () {
                openFlexibleDialog(context, appId + '/chat',
                    title: 'Chat with one of your followers',
                    child: MembersWidget(
                      appId: appId,
                      selectedMember: (String memberId) async {
                        var room = await RoomHelper.getRoomForMember(
                            appId, widget.memberId, memberId);
*//*
                            ChatPage.openRoom(
                                context, room, widget.memberId);
*//*
                      },
                      currentMemberId: memberId,
                    ),
                    buttons: [
                      dialogButton(context,
                          label: 'Close',
                          onPressed: () => Navigator.of(context).pop()),
                    ]);
              })),
    ]);*/
  }
}
