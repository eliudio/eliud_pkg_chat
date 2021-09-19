import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart'
    as ChatMemberInfoListEvent;
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_state.dart';
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
                  separatorBuilder: (context, index) => divider(context),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    final value = values[index];

                    var roomId = value!.documentID!;
                    return StreamBuilder<List<ChatMemberInfoModel?>>(
                        stream: chatMemberInfoRepository(
                                appId: widget.appId, roomId: roomId)!
                            .values(
                                eliudQuery: EliudQuery()
                                    .withCondition(EliudQueryCondition(
                                        'readAccess',
                                        arrayContains: widget.memberId))),
                        builder: (context, snapshot) {
                          DateTime? memberLastRead;
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            var list = snapshot.data;
                            if ((list != null) && (list.isNotEmpty)) {
                              var memberValue = list.firstWhere((element) => element!.authorId == widget.memberId, orElse: () => null);
                              if ((memberValue != null) &&
                                  (memberValue.timestamp != null)) {
                                try {
                                  memberLastRead = memberValue.timestamp!;
                                } catch (_) {}
                              }
                            }
                          }

                          var timestampRoom;
                          if (value.timestamp != null) {
                            timestampRoom = value.timestamp;
                          } else {
                            timestampRoom = DateTime.now();
                          }
                          try {
                            if (memberLastRead != null) {
                              return member(
                                  context,
                                  (timestampRoom.compareTo(memberLastRead) > 0),
                                  timestampRoom,
                                  value);
                            }
                          } catch (_) {}

                          return member(context, true, timestampRoom, value);
                        });
                  }));
        } else {
          return const Text("No active conversations");
        }
      } else {
        return progressIndicator(context);
      }
    });
  }

  Widget member(BuildContext context, bool hasUnread, DateTime? timestampRoom,
      RoomModel room) {
    return FutureBuilder<OtherMembersRoomInfo?>(
        future: getOtherMembersRoomInfo(room.appId!, room.members!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            OtherMembersRoomInfo otherMembersRoomInfo = snapshot.data!;
            var nameList = otherMembersRoomInfo.otherMembersRoomInfo
                .map((e) => e.name)
                .toList();
            var names = nameList.join(", ");

            var nameWidget = hasUnread
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
              itemCount: otherMembersRoomInfo.otherMembersRoomInfo.length,
              itemBuilder: (context, i) =>
                  otherMembersRoomInfo.otherMembersRoomInfo[i].avatar,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              staggeredTileBuilder: (_) => const StaggeredTile.fit(100),
            );

            return ListTile(
                onTap: () async {
                  ChatDashboardBloc.openRoom(context, room, widget.memberId);
                },
                trailing: text(
                        context,
                        timestampRoom != null
                            ? formatHHMM(timestampRoom)
                            : 'now'),
                leading: Container(
                  height: 100,
                  width: 100,
                  child: staggeredPhotos,
                ),
                title: nameWidget);
          }
          return progressIndicator(context);
        });
  }

  Future<OtherMembersRoomInfo> getOtherMembersRoomInfo(
      String appId, List<String> memberIds) async {
    List<OtherMemberRoomInfo> otherMembersRoomInfo = [];
    for (var memberId in memberIds) {
      if (memberId != widget.memberId) {
        var member =
            await memberPublicInfoRepository(appId: appId)!.get(memberId);
        if (member != null) {
          var otherMemberRoomInfo = OtherMemberRoomInfo(
              name: member.name != null ? member.name! : 'No name',
              avatar: member.photoURL != null
                  ? FadeInImage.memoryNetwork(
                      height: 50,
                      placeholder: kTransparentImage,
                      image: member.photoURL!,
                    )
                  : const Center(child: Text('No photo')));
          otherMembersRoomInfo.add(otherMemberRoomInfo);
        }
      }
    }
    return OtherMembersRoomInfo(otherMembersRoomInfo);
  }
}

class OtherMemberRoomInfo {
  final String name;
  final Widget avatar;

  OtherMemberRoomInfo({required this.name, required this.avatar});
}

class OtherMembersRoomInfo {
  final List<OtherMemberRoomInfo> otherMembersRoomInfo;

  OtherMembersRoomInfo(this.otherMembersRoomInfo);
}
