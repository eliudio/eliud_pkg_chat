import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/sty'
    'le/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_style.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_text_form_field.dart';
import 'package:eliud_core/tools/random.dart';
import 'chat_bloc/chat_bloc.dart';
import 'chat_bloc/chat_event.dart';
import 'chat_bloc/chat_state.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_view/split_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'all_chats_bloc/all_chats_bloc.dart';
import 'all_chats_bloc/all_chats_event.dart';
import 'all_chats_bloc/all_chats_state.dart';
import 'chat_widget.dart';
import 'members_widget.dart';

class AllChatsWidget extends StatefulWidget {
  final String memberId;
  final String appId;

  const AllChatsWidget({
    Key? key,
    required this.appId,
    required this.memberId,
  }) : super(key: key);

  @override
  AllChatsWidgetState createState() => AllChatsWidgetState();
}

class AllChatsWidgetState extends State<AllChatsWidget> {
  SplitViewController? _splitViewController;

  @override
  void initState() {
    _splitViewController = SplitViewController(weights: [
      0.3,
      0.7
    ], limits: [
      WeightLimit(min: 0.2, max: 0.8),
      WeightLimit(min: 0.2, max: 0.8)
    ]);
    super.initState();
  }

  double HEADER_HEIGHT = 60;
  Widget header() {
    return SizedBox(
        height: HEADER_HEIGHT,
        child: Column(children: [
          Row(children: [
            const Spacer(),
            button(context, label: 'Member', onPressed: () {
              openFlexibleDialog(context, widget.appId + '/chat',
                  title: 'Chat with one of your followers',
                  child: MembersWidget(
                    appId: widget.appId,
                    selectedMember: (String memberId) async {
                      var room = await RoomHelper.getRoomForMember(
                          widget.appId, widget.memberId, memberId);
                      selectRoom(context, room);
                    },
                    currentMemberId: widget.memberId,
                  ),
                  buttons: [
                    dialogButton(context,
                        label: 'Close',
                        onPressed: () => Navigator.of(context).pop()),
                  ]);
            }),
            const Spacer(),
          ]),
          divider(context),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllChatsBloc, AllChatsState>(builder: (context, state) {
      if (state is AllChatsLoaded) {
        final chats = state.enhancedRoomModels;
        final currentChat = state.currentRoom;
        return OrientationBuilder(builder: (context, orientation) {
          //var weight = _splitViewController!.weights[0]!;
          return SplitView(
              gripColor: Colors.red,
              controller: _splitViewController,
              onWeightChanged: (newWeight) {
                setState(() {});
              },
              children: [
                ListView(children: [
                  header(),
                  if (chats != null)
                    ListView.separated(
                        separatorBuilder: (context, index) => divider(context),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final value = chats[index];
                          return roomListEntry(value);
                        })
                ]),
                if (currentChat != null)
                  ChatWidget(
                    memberId: widget.memberId,
                  )
                else
                  Container()
              ],
              viewMode: orientation == Orientation.landscape
                  ? SplitViewMode.Horizontal
                  : SplitViewMode.Vertical);
        });
      } else {
        return progressIndicator(context);
      }
    });
  }

  Widget roomListEntry(EnhancedRoomModel room) {
    var timestampRoom = (room.roomModel.timestamp != null)
        ? room.roomModel.timestamp!
        : DateTime.now();
    var nameList = room.otherMembersRoomInfo.map((e) => e.name).toList();
    var names = nameList.join(", ");

    var nameWidget = room.hasUnread
        ? highLight1(
            context,
            names,
          )
        : text(
            context,
            names,
          );
    Widget staggeredPhotos = StaggeredGridView.extentBuilder(
      scrollDirection: Axis.horizontal,
      primary: true,
      maxCrossAxisExtent: 150,
      itemCount: room.otherMembersRoomInfo.length,
      itemBuilder: (context, i) {
        var avatar = room.otherMembersRoomInfo[i].avatar;
        if (avatar != null) {
          return FadeInImage.memoryNetwork(
            height: 50,
            placeholder: kTransparentImage,
            image: avatar,
          );
        } else {
          return const Center(child: Text('No photo'));
        }
      },
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      staggeredTileBuilder: (_) => const StaggeredTile.fit(100),
    );

    return ListTile(
        onTap: () async {
          selectRoom(context, room.roomModel);
        },
        trailing: text(
            context, timestampRoom != null ? formatHHMM(timestampRoom) : 'now'),
        leading: SizedBox(
          height: 100,
          width: 100,
          child: staggeredPhotos,
        ),
        title: nameWidget);
  }
}


void selectRoom(BuildContext context, RoomModel room) {
  BlocProvider.of<AllChatsBloc>(context).add(SelectChat(selected: room));
}
