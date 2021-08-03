import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_pkg_chat/extensions/chat/chat.dart';
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
            } catch (_) {}
          }
        }
      }
      var room = value;
      try {
        var timestampRoom = dateTimeFromTimestampString(room!.timestamp!);
        if (memberLastRead == null) {
          return member(context, true, timestampRoom);
        } else {
          return member(context, (timestampRoom.compareTo(memberLastRead!) > 0),
              timestampRoom);
        }
      } catch(_) {
        return member(context, false, null);
      }
    });
  }

  Widget member(BuildContext context, bool hasUnread, DateTime? timestampRoom) {
    return FutureBuilder<OtherMembersRoomInfo?>(
        future: getOtherMembersRoomInfo(value!.appId!, value!.members!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            OtherMembersRoomInfo otherMembersRoomInfo = snapshot.data!;
            var nameList = otherMembersRoomInfo.otherMembersRoomInfo
                .map((e) => e.name)
                .toList();
            var names = nameList.join(", ");

            var nameWidget = hasUnread
                ? StyleRegistry.registry()
                    .styleWithContext(context)
                    .frontEndStyle()
                    .textStyle()
                    .highLight1(
                      context,
                      names,
                    )
                : StyleRegistry.registry()
                    .styleWithContext(context)
                    .frontEndStyle()
                    .textStyle()
                    .text(
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
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              staggeredTileBuilder: (_) => const StaggeredTile.fit(100),
            );

            return ListTile(
                onTap: () async {
                  ChatDashboardBloc.openRoom(context, value!, currentMemberId);
                },
                trailing: StyleRegistry.registry()
                    .styleWithContext(context)
                    .frontEndStyle()
                    .textStyle()
                    .text(context, timestampRoom != null ? formatHHMM(timestampRoom) : 'now'),
                leading: Container(
                  height: 100,
                  width: 100,
                  child: staggeredPhotos,
                ),
                title: nameWidget);
          }
          return StyleRegistry.registry()
              .styleWithContext(context)
              .frontEndStyle()
              .progressIndicatorStyle()
              .progressIndicator(context);
        });
  }

  Future<OtherMembersRoomInfo> getOtherMembersRoomInfo(
      String appId, List<String> memberIds) async {
    List<OtherMemberRoomInfo> otherMembersRoomInfo = [];
    for (var memberId in memberIds) {
      if (memberId != currentMemberId) {
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
