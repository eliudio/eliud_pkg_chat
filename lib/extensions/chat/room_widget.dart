import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/extensions/chat/room_list_widget.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class RoomWidget extends StatefulWidget {
  const RoomWidget({
    Key? key,
  }) : super(key: key);

  @override
  RoomWidgetState createState() => RoomWidgetState();
}

class RoomWidgetState extends State<RoomWidget> {
  @override
  Widget build(BuildContext context) {
    var accessState = AccessBloc.getState(context);
    if (accessState is AppLoaded) {
      var appId = accessState.app.documentID;
      if (accessState.getMember() != null) {
        var memberId = accessState.getMember()!.documentID!;
        var eliudQuery = EliudQuery()
            .withCondition(EliudQueryCondition('appId', isEqualTo: appId))
            .withCondition(EliudQueryCondition('members',
            arrayContains: memberId));
        return BlocProvider(
          create: (_) =>
          RoomListBloc(
              orderBy: 'timestamp',
              descending: true,
              eliudQuery: eliudQuery,
              roomRepository: roomRepository(appId: appId)!)
            ..add(LoadRoomList()),
          child: const RoomListWidget(),
        );
      } else {
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle().text(context, 'No rooms available. Log on first');
      }
    } else {
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .progressIndicatorStyle()
          .progressIndicator(context);
    }
  }
}
