import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_cache.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_cache.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_firestore.dart';
import 'package:eliud_pkg_chat/model/chat_firestore.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_follow/model/following_list.dart';
import 'package:eliud_pkg_follow/model/following_list_event.dart';
import 'package:eliud_pkg_follow/model/following_model.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_follow/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_follow/model/following_dashboard_model.dart';
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

class FollowingDashboardItem extends StatelessWidget {
  final String currentMemberId;
  final FollowingModel? value;
  final String? appId;
  final FollowingView? followingView;

  FollowingDashboardItem({
    Key? key,
    required this.currentMemberId,
    this.followingView,
    required this.value,
    this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = followingView == FollowingView.Followers
        ? value!.follower
        : value!.followed;
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
          // start conversation
          var roomId;
          var otherMemberId = value!.follower!.documentID!;
          if (currentMemberId.compareTo(otherMemberId) < 0) {
            roomId = currentMemberId + '-' + otherMemberId;
          } else {
            roomId = otherMemberId + '-' + currentMemberId;
          }
          var roomModel =
              await roomRepository(appId: appId!)!.get(roomId, onError: (_) {});
          if (roomModel == null) {
            roomModel = RoomModel(
              documentID: roomId,
              ownerId: currentMemberId,
              appId: appId,
              description:
                  'Chat between ' + currentMemberId + ' and ' + otherMemberId,
              isRoom: false,
              members: [
                currentMemberId,
                otherMemberId,
              ],
            );
            roomRepository(appId: appId!)!.add(roomModel);
          }
          var subCollection =
              roomRepository(appId: appId!)!.getSubCollection(roomId, 'chat');
          var chatRepository = ChatCache(ChatFirestore(subCollection, appId!));
          var chatModel = ChatModel(
            documentID: newRandomKey(),
            roomId: roomId,
            authorId: currentMemberId,
            appId: appId,
            saying: 'hello',
            readAccess: [
              currentMemberId,
              otherMemberId,
            ],
          );
          var value2 = await chatRepository.get('1c5322b4-0ff0-412b-a58e-9c4e5153acad');
          chatRepository.add(chatModel);
        },
        leading: const Icon(Icons.chat_bubble_outline),
        trailing: Container(
          height: 100,
          width: 100,
          child: photo,
        ),
        title: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle()
            .text(
              context,
              name,
            ));
  }
}
