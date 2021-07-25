import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_event.dart';
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
    var data = value!.followed;
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
          BlocProvider.of<ChatDashboardBloc>(context)
              .add(CreateChatWithMemberEvent(value!.followed!.documentID!, value!.follower!.documentID!, 1));
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
