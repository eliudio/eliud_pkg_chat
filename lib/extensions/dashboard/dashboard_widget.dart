import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/members_widget.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/room_widget.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import '../chat_dashboard_component.dart';
import 'bloc/chat_dashboard_bloc.dart';
import 'bloc/chat_dashboard_state.dart';

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      SizedBox(
          height:
              MediaQuery.of(context).size.height - ChatDashboard.HEADER_HEIGHT,
          width: double.infinity,
          child: BlocBuilder<ChatDashboardBloc, ChatDashboardState>(
              builder: (context, state) {
            return RoomsWidget(appId: appId, memberId: memberId);
          })),
      Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
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
                StyleRegistry.registry()
                    .styleWithContext(context)
                    .frontEndStyle()
                    .dialogStyle()
                    .openFlexibleDialog(context,
                        title: 'Chat with one of your followers',
                        child: MembersWidget(
                          appId: appId,
                          selectedMember: (String memberId) async {
                            var room = await RoomHelper.getRoomForMember(
                                appId, widget.memberId, memberId);
                            ChatDashboardBloc.openRoom(
                                context, room, widget.memberId);
                          },
                          currentMemberId: memberId,
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
              })),
    ]);
  }
}
