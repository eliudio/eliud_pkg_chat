import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart'
    as ChatMemberInfoListEvent;
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_event.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_state.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:eliud_pkg_follow/model/following_list.dart';
import 'package:eliud_pkg_follow/model/following_list_event.dart';
import 'package:eliud_pkg_follow/model/following_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_follow/model/following_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class MembersWidget extends StatefulWidget {
  final String appId;
  final String memberId;

  const MembersWidget({
    required this.appId,
    required this.memberId,
    Key? key,
  }) : super(key: key);

  @override
  MembersWidgetState createState() => MembersWidgetState(appId, memberId);
}

class MembersWidgetState extends State<MembersWidget> {
  final String appId;
  final String memberId;

  MembersWidgetState(this.appId, this.memberId);

  static EliudQuery? getQuery(String memberId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition('followedId', isEqualTo: memberId),
    ]);
  }

  Widget widgetProvider(String appId, FollowingModel value) {
    return FollowingDashboardItem(
        currentMemberId: memberId, appId: appId, value: value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowingListBloc>(
        create: (context) => FollowingListBloc(
              eliudQuery: getQuery(widget.memberId),
              detailed: true,
              followingRepository: followingRepository(appId: widget.appId)!,
            )..add(LoadFollowingList()),
        child: FollowingListWidget(
            readOnly: true,
            widgetProvider: (value) => widgetProvider(appId, value!),
            listBackground: BackgroundModel(documentID: "`transparent")));
  }
}

/*
          BlocProvider<ChatMemberInfoListBloc>(
              create: (context) => ChatMemberInfoListBloc(
                eliudQuery: eliudQueryChatMemberInfoList,
                chatMemberInfoRepository: chatMemberInfoRepository(
                    appId: widget.appId, roomId: widget.roomId)!,
              )..add(ChatMemberInfoListEvent.LoadChatMemberInfoList())),

 */
// todo: search for the member in the room and if the room has messages that I didn't read yet then put this member bold
class FollowingDashboardItem extends StatelessWidget {
  final String currentMemberId;
  final FollowingModel? value;
  final String? appId;

  const FollowingDashboardItem({
    Key? key,
    required this.currentMemberId,
    required this.value,
    this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otherMember = value!.follower!.documentID!;
    var roomId = RoomHelper.getRoomKey(currentMemberId, otherMember);
    var eliudQueryRoomList = EliudQuery()
        .withCondition(EliudQueryCondition('__name__', isEqualTo: roomId));
    var chatMemberInfoId = RoomHelper.getChatMemberInfoId(currentMemberId, roomId);
    var eliudQueryChatMemberInfoList = EliudQuery()
        .withCondition(EliudQueryCondition('__name__', isEqualTo: chatMemberInfoId));
    return MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<RoomListBloc>(
              create: (context) => RoomListBloc(
                    paged: true,
                    eliudQuery: eliudQueryRoomList,
                    roomRepository: roomRepository(appId: appId)!,
                  )..add(LoadRoomList())),
          BlocProvider<ChatMemberInfoListBloc>(
              create: (context) => ChatMemberInfoListBloc(
                    eliudQuery: eliudQueryChatMemberInfoList,
                    chatMemberInfoRepository:
                        chatMemberInfoRepository(appId: appId, roomId: roomId)!,
                  )..add(ChatMemberInfoListEvent.LoadChatMemberInfoList())),
        ],
        child: child(context));
  }

  Widget child(BuildContext context) {
    DateTime? memberLastRead;
    return BlocBuilder<ChatMemberInfoListBloc, ChatMemberInfoListState>(
        builder: (chatMemberInfoContext, chatMemberInfoState) {
      if (chatMemberInfoState is ChatMemberInfoListLoaded) {
        if ((chatMemberInfoState.values != null) &&
            (chatMemberInfoState.values!.isNotEmpty)) {
          var value = chatMemberInfoState.values![0];
          if ((value != null) && (value.timestamp != null)) {
            memberLastRead = dateTimeFromTimestampString(value.timestamp!);
          }
        }
      }
      return BlocBuilder<RoomListBloc, RoomListState>(
          builder: (context, state) {
        if (state is RoomListState) {
          if (state is RoomListLoaded) {
            if (state.values != null) {
              if (state.values!.isNotEmpty) {
                var room = state.values![0];
                if (room != null) {
                  if (memberLastRead == null) return member(context, true);
                  var timestampRoom = dateTimeFromTimestampString(room.timestamp!);
                  var hasUnread = (timestampRoom.compareTo(memberLastRead!) >
                      0);
                  return member(context, hasUnread);
                }
              }
            }
          }
        }
        return member(context, false);
      });
    });
  }

  Widget member(BuildContext context, bool hasUnread) {
    var data = value!.follower;
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
    return ListTile(
        onTap: () async {
          // todo:
          // am I following this person? If not: send invite
          // else:
          BlocProvider.of<ChatDashboardBloc>(context).add(
              CreateChatWithMemberEvent(value!.followed!.documentID!,
                  value!.follower!.documentID!, 0));
        },
        leading: const Icon(Icons.chat_bubble_outline),
        trailing: Container(
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
