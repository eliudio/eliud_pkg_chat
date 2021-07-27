import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/extensions/chat/chat.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/members_widget.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import 'bloc/chat_dashboard_bloc.dart';
import 'bloc/chat_dashboard_event.dart';
import 'bloc/chat_dashboard_state.dart';

class DashboardWidget extends StatefulWidget {
  final String appId;
  final String memberId;

  const DashboardWidget({
    Key? key, required this.appId, required this.memberId,
  }) : super(key: key);

  @override
  DashboardWidgetState createState() => DashboardWidgetState(appId, memberId);
}

class DashboardWidgetState extends State<DashboardWidget>  with SingleTickerProviderStateMixin {
  final String appId;
  final String memberId;

  TabController? _tabController;

  DashboardWidgetState(this.appId, this.memberId);

  @override
  void initState() {
    var size = 6;
    _tabController = TabController(vsync: this, length: size);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.index = 0;

    super.initState();
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
    super.dispose();
  }

  void _handleTabSelection() {
    if ((_tabController != null) && (_tabController!.indexIsChanging)) {
      ChatDashboardBloc.selectOption(context, _tabController!.index);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDashboardBloc, ChatDashboardState>(builder: (context, state) {
      if (state is UnreadWidgetState) {
        return tabbed(const Text('A list of unread messages'));
      } else if (state is MemberRoomsWidgetState) {
        return tabbed(MembersWidget(appId: appId, memberId: memberId));
      } else if (state is RealRoomFormsWidgetState) {
        return tabbed(const Text('A form with details to create a new room, including name of room and ok button'));
      } else if (state is ExistingMemberRoomsWidgetState) {
        return tabbed(const Text('Here a list of existing chats, i.e. RoomWidget where isRoom = false (or create another entity specific for this)'));
      } else if (state is ExistingRealRoomsWidgetState) {
        return tabbed(RoomsWidget(appId: appId, memberId: memberId));
      } else if (state is ChatWidgetState) {
        return ChatPage(appId: state.room.appId!, roomId: state.room.documentID!, memberId: memberId, members: state.room.members!, height: height(context), selectedOptionBeforeChat: state.selectedOptionBeforeChat);
      }
      return StyleRegistry.registry().styleWithContext(context)
          .frontEndStyle().progressIndicatorStyle().progressIndicator(context);
    });
  }

  Widget tabbed(Widget widget) {
    var items = ['Unread', 'Chat', 'Room', 'Chats', 'Rooms', 'Close'];
    return Column(children: [
      StyleRegistry.registry().styleWithContext(context)
          .frontEndStyle()
          .tabsStyle()
          .tabBar(context, items: items, tabController: _tabController!),
      contained(widget)
    ]);
  }

  double height(BuildContext context) {
    return MediaQuery.of(context).size.height * .8;
  }

  double remainingHeight(BuildContext context) {
    return height(context) - 55;
  }

  Widget contained(Widget widget) {
    return Container(height: remainingHeight(context), child: widget);
  }
}
