import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/extensions/widgets/room_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'members_widget.dart';

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
      if (_tabController!.index == 5) {
        Navigator.of(context).pop();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var items = ['Unread', 'Chat', 'Room', 'Chats', 'Rooms', 'Close'];
    var widget;
    switch (_tabController!.index) {
      case 0: widget = const Text('A list of unread messages'); break;
      case 1: widget = MembersWidget(appId: appId, memberId: memberId); break;
      case 2: widget = const Text('A form with details to create a new room, including name of room and ok button'); break;
      case 3: widget = const Text('Here a list of existing chats, i.e. RoomWidget where isRoom = false (or create another entity specific for this)'); break;
      case 4: widget = RoomsWidget(appId: appId, memberId: memberId); break;
      case 5: widget = Container(); break;
    }
    return Column(children: [
        StyleRegistry.registry().styleWithContext(context)
        .frontEndStyle()
        .tabsStyle()
        .tabBar(context, items: items, tabController: _tabController!),
       Container(height: MediaQuery.of(context).size.height *.8, child: widget)
    ]);
  }
}
