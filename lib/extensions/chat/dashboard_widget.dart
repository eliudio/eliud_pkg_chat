import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/extensions/chat/room_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({
    Key? key,
  }) : super(key: key);

  @override
  DashboardWidgetState createState() => DashboardWidgetState();
}

class DashboardWidgetState extends State<DashboardWidget>  with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    var size = 5;
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var items = ['New chat', 'New room', 'Chats', 'Rooms', 'Status'];
    var widget;
    switch (_tabController!.index) {
      case 0: widget = const Text('A list of members, when selected start a chat'); break;
      case 1: widget = const Text('A form with details to create a new room, including name of room and ok button'); break;
      case 2: widget = const Text('Here a list of existing chats, i.e. RoomWidget where isRoom = false (or create another entity specific for this)'); break;
      case 3: widget = const RoomWidget(); break;
      case 4: widget = const Text('Here perhaps status'); break;
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
