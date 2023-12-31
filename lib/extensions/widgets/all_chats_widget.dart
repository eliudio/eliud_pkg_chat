import 'package:eliud_core_helpers/firestore/firestore_tools.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_button.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog.dart';
import 'package:eliud_core_main/apis/style/frontend/has_divider.dart';
import 'package:eliud_core_main/apis/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core_main/apis/style/frontend/has_split.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:eliud_pkg_chat_model/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat_model/model/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'all_chats_bloc/all_chats_bloc.dart';
import 'all_chats_bloc/all_chats_event.dart';
import 'all_chats_bloc/all_chats_state.dart';
import 'chat_widget.dart';
import 'members_widget.dart';
import 'dart:math';

class AllChatsWidget extends StatefulWidget {
  final String memberId;
  final AppModel app;
  final MembersType? membersType;
  final List<String> blockedMembers;

  const AllChatsWidget({
    super.key,
    required this.blockedMembers,
    required this.app,
    required this.memberId,
    required this.membersType,
  });

  @override
  AllChatsWidgetState createState() => AllChatsWidgetState();
}

class AllChatsWidgetState extends State<AllChatsWidget> {
  double headerHeight = 60;
  Widget header() {
    return SizedBox(
        height: headerHeight,
        child: Column(children: [
          Row(children: [
            const Spacer(),
            button(widget.app, context, label: 'Member', onPressed: () {
              openFlexibleDialog(
                  widget.app, context, '${widget.app.documentID}/chat',
                  title: 'Chat with one of these members',
                  child: MembersWidget(
                    blockedMembers: widget.blockedMembers,
                    membersType: widget.membersType,
                    app: widget.app,
                    selectedMember: (String memberId) async {
                      var room = await RoomHelper.getRoomForMembers(
                          widget.app.documentID,
                          widget.memberId,
                          [widget.memberId, memberId]);
                      selectRoom(context, room);
                    },
                    currentMemberId: widget.memberId,
                  ),
                  buttons: [
                    dialogButton(widget.app, context,
                        label: 'Close',
                        onPressed: () => Navigator.of(context).pop()),
                  ]);
            }),
            const Spacer(),
          ]),
          divider(widget.app, context),
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
          return splitView(
              widget.app,
              context,
              ListView(children: [
                header(),
                ListView.separated(
                    separatorBuilder: (context, index) =>
                        divider(widget.app, context),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final value = chats[index];
                      return roomListEntry(
                          value,
                          currentChat == null
                              ? false
                              : value.roomModel.documentID ==
                                  currentChat.documentID);
                    })
              ]),
              (currentChat != null)
                  ? ChatWidget(
                      app: widget.app,
                      blockedMembers: widget.blockedMembers,
                      memberId: widget.memberId,
                      canAddMember: widget.memberId == currentChat.ownerId,
                      membersType: widget.membersType,
                    )
                  : Container(),
              0.3,
              0.2,
              0.8);
        });
      } else {
        return progressIndicator(widget.app, context);
      }
    });
  }

  Widget roomListEntry(EnhancedRoomModel room, bool isCurrent) {
    var timestampRoom = (room.roomModel.timestamp != null)
        ? room.roomModel.timestamp!
        : DateTime.now();
    var nameList = room.otherMembersRoomInfo.map((e) => e.name).toList();
    var names = nameList.join(", ");
    if (isCurrent) names = "*$names";

    var nameWidget = room.hasUnread
        ? highLight1(
            widget.app,
            context,
            names,
          )
        : text(
            widget.app,
            context,
            names,
          );

    int amountOfAvatars = 0;
    List<Widget> widgets = [];
    if (room.otherMembersRoomInfo.length > 1) {
      widgets.add(const Icon(Icons.group));
      amountOfAvatars = 1;
    } else {
      for (int i = 0; i < room.otherMembersRoomInfo.length; i++) {
        var avatar = room.otherMembersRoomInfo[i].avatar;
        if (avatar != null) {
          widgets.add(FadeInImage.memoryNetwork(
            height: 10,
            placeholder: kTransparentImage,
            image: avatar,
          ));
          amountOfAvatars++;
        } else {
          widgets.add(const Icon(Icons.person));
        }
      }
    }

    const double photoSize = 50;
    const double spacing = 1;

    Widget staggeredPhotos;
    if (amountOfAvatars >= 1) {
      var sqrtValue = sqrt(amountOfAvatars);
      var maxCrossAxisExtend = (photoSize - (sqrtValue - 1)) / sqrtValue;
      staggeredPhotos = GridView.extent(
          maxCrossAxisExtent: maxCrossAxisExtend,
          padding: const EdgeInsets.all(0),
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          physics: const ScrollPhysics(),
          // to disable GridView's scrolling
          shrinkWrap: true,
          children: widgets);
    } else {
      staggeredPhotos = const Icon(Icons.error);
    }

    var theTime = formatHHMM(timestampRoom);
    return ListTile(
        onTap: () async {
          selectRoom(context, room.roomModel);
        },
        trailing: text(widget.app, context, theTime),
        leading: SizedBox(
          height: photoSize,
          width: photoSize,
          child: staggeredPhotos,
        ),
        title: nameWidget);
  }
}

void selectRoom(BuildContext context, RoomModel room) {
  BlocProvider.of<AllChatsBloc>(context).add(SelectChat(selected: room));
}
