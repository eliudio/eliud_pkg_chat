import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_list.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsWidget extends StatefulWidget {
  final String appId;
  final String memberId;

  const RoomsWidget({
    Key? key, required this.appId, required this.memberId,
  }) : super(key: key);

  @override
  RoomsWidgetState createState() => RoomsWidgetState();
}

class RoomsWidgetState extends State<RoomsWidget> {
  @override
  Widget build(BuildContext context) {
    var eliudQuery = EliudQuery()
        .withCondition(EliudQueryCondition('appId', isEqualTo: widget.appId))
        .withCondition(EliudQueryCondition('members',
        arrayContains: widget.memberId));
    return BlocProvider(
      create: (_) =>
      RoomListBloc(
          orderBy: 'timestamp',
          descending: true,
          eliudQuery: eliudQuery,
          roomRepository: roomRepository(appId: widget.appId)!)
        ..add(LoadRoomList()),
      child: const RoomListWidget(),
    );
  }
}

class RoomListWidget extends StatefulWidget {
  const RoomListWidget({
    Key? key,
  }) : super(key: key);

  @override
  RoomListWidgetState createState() => RoomListWidgetState();
}

class RoomListWidgetState extends State<RoomListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
      if (state is RoomListLoaded) {
        final values = state.values;
        if (values != null) {
          return Container(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      StyleRegistry.registry().styleWithContext(context)
                          .frontEndStyle().dividerStyle()
                          .divider(context),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    final value = values[index];

                    return RoomListItem(
                      value: value,
                      onDismissed: (direction) {
                        // delete the Room
                      },
                      onTap: () async {
                        // open the Room
                      },
                    );
                  }
              ));
        } else {
          return const Text("No active conversations");
        }
      } else {
        return StyleRegistry.registry()
            .styleWithContext(context)
            .adminListStyle()
            .progressIndicator(context);
      }
    });
  }
}
