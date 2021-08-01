import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_pkg_chat/extensions/chat/chat.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart'
    as ChatMemberInfoListEvent;
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/screen_size.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_event.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_state.dart';
import 'package:eliud_pkg_chat/model/room_list.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../chat_dashboard_component.dart';

class RoomsWidget extends StatefulWidget {
  final String appId;
  final String memberId;

  const RoomsWidget({
    Key? key,
    required this.appId,
    required this.memberId,
  }) : super(key: key);

  @override
  RoomsWidgetState createState() => RoomsWidgetState();
}

class RoomsWidgetState extends State<RoomsWidget> {
  @override
  Widget build(BuildContext context) {
    var eliudQuery = EliudQuery()
        .withCondition(EliudQueryCondition('appId', isEqualTo: widget.appId))
        .withCondition(
            EliudQueryCondition('members', arrayContains: widget.memberId));
    return BlocProvider(
      create: (_) => RoomListBloc(
          orderBy: 'timestamp',
          descending: true,
          eliudQuery: eliudQuery,
          roomRepository: roomRepository(appId: widget.appId)!)
        ..add(LoadRoomList()),
      child: RoomListWidget(appId: widget.appId, memberId: widget.memberId),
    );
  }
}

class RoomListWidget extends StatefulWidget {
  final String memberId;
  final String appId;

  const RoomListWidget({
    Key? key,
    required this.appId,
    required this.memberId,
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
                  separatorBuilder: (context, index) => StyleRegistry.registry()
                      .styleWithContext(context)
                      .frontEndStyle()
                      .dividerStyle()
                      .divider(context),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    final value = values[index];

                    var roomId = value!.documentID!;
                    var chatMemberInfoId =
                        RoomHelper.getChatMemberInfoId(widget.memberId, roomId);
                    var eliudQueryChatMemberInfoList = EliudQuery()
                        .withCondition(EliudQueryCondition('__name__',
                            isEqualTo: chatMemberInfoId));

                    return BlocProvider<ChatMemberInfoListBloc>(
                        create: (_) => ChatMemberInfoListBloc(
                              eliudQuery: eliudQueryChatMemberInfoList,
                              chatMemberInfoRepository:
                                  chatMemberInfoRepository(
                                      appId: widget.appId, roomId: roomId)!,
                            )..add(ChatMemberInfoListEvent
                                .LoadChatMemberInfoList()),
                        child: RoomItem(
                          value: value,
                          currentMemberId: widget.memberId,
/*
                      onDismissed: (direction) {
                        // delete the Room
                      },
*/
                        ));
                  }));
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
/*

class MyRoomListItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final RoomModel? value;

  MyRoomListItem({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.red,
      onTap: onTap,
      trailing: Text(value!.timestamp!),
      title: Hero(
        tag: '${value!.documentID}__RoomheroTag',
        child: Container(
          width: fullScreenWidth(context),
          child: Center(
              child: StyleRegistry.registry()
                  .styleWithContext(context)
                  .adminListStyle()
                  .listItem(context, value!.documentID!)),
        ),
      ),
      subtitle:
          (value!.description! != null) && (value!.description!.isNotEmpty)
              ? Center(
                  child: StyleRegistry.registry()
                      .styleWithContext(context)
                      .adminListStyle()
                      .listItem(context, value!.description!))
              : null,
    );
  }
}
*/

class RoomItem extends StatelessWidget {
  final String currentMemberId;
  final RoomModel? value;
  final String? appId;

  const RoomItem({
    Key? key,
    required this.currentMemberId,
    required this.value,
    this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? memberLastRead;
    return BlocBuilder<ChatMemberInfoListBloc, ChatMemberInfoListState>(
        builder: (chatMemberInfoContext, chatMemberInfoState) {
      if (chatMemberInfoState is ChatMemberInfoListLoaded) {
        if ((chatMemberInfoState.values != null) &&
            (chatMemberInfoState.values!.isNotEmpty)) {
          var value = chatMemberInfoState.values![0];
          if ((value != null) && (value.timestamp != null)) {
            try {
              memberLastRead = dateTimeFromTimestampString(value.timestamp!);
            } catch (_) {
            }
          }
        }
      }
      var room = value;
      var timestampRoom = dateTimeFromTimestampString(room!.timestamp!);
      if (memberLastRead == null) {
        return member(context, true, timestampRoom);
      } else {
        return member(context, (timestampRoom.compareTo(memberLastRead!) > 0),
            timestampRoom);
      }
    });
  }

  Widget member(BuildContext context, bool hasUnread, DateTime timestampRoom) {
    // retrieve icon and name for the member(s)
/*
    if (value!.members.length > 2) {

    } else {
      var data = value!.follower;
    }
    var photo;
    var name;
    if (data == null) {
      photo = const Text('No photo provided');
      name = 'No name';
    } else {
      photo = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: data.photoURL!,
      );
      name = data.name;
    }
*/
    var photo = const Text('No photo provided');
    var name = 'No name';
    return ListTile(
        onTap: () async {
          StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .dialogStyle()
              .openFlexibleDialog(context,
                  title: 'Chat',
                  child: ChatPage(
                    memberId: currentMemberId,
                    roomId: value!.documentID!,
                    members: value!.members!,
                    selectedOptionBeforeChat: 0,
                    height: MediaQuery.of(context).size.height - ChatDashboard.HEADER_HEIGHT,
                    appId: value!.appId!,
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
/*
          BlocProvider.of<ChatDashboardBloc>(context)
              .add(OpenRoomEvent(value!));
*/
          // open the Room
        },
        trailing: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(context, formatHHMM(timestampRoom)),
        leading: Container(
          height: 100,
          width: 100,
          child: photo,
        ),
        title: hasUnread
            ? StyleRegistry.registry()
                .styleWithContext(context)
                .frontEndStyle()
                .textStyle()
                .highLight1(
                  context,
                  name,
                )
            : StyleRegistry.registry()
                .styleWithContext(context)
                .frontEndStyle()
                .textStyle()
                .text(
                  context,
                  name,
                ));
  }
}
