import 'package:eliud_core/core/navigate/page_param_helper.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  physics: ScrollPhysics(),
                  itemCount: values!.length,
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
          return Text("No active conversations");
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
