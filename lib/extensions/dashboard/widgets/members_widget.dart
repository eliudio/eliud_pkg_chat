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

typedef SelectedMember = Function(String memberId);

// It seems fair:
// - You can invite one of your followers to chat.
// - You can't invite some you are following to a chat.
// It seems fair because, if someone follows you he has allowed this
// But: This is not enforced through rules
// Also it means that, ones you do not follow someone, but that someone is following you and started a chat
// then you have a conversation with someone you do not follow
// We'll introduce blocking functionality at some point
// Also, we should allow the initiator of a chat to delete the chat
// Also, we should allow the initiator of a chat to delete the chat
class MembersWidget extends StatefulWidget {
  final String appId;
  final String currentMemberId;
  final SelectedMember selectedMember;

  const MembersWidget({
    required this.appId,
    required this.currentMemberId,
    required this.selectedMember,
    Key? key,
  }) : super(key: key);

  @override
  MembersWidgetState createState() =>
      MembersWidgetState(appId, currentMemberId);
}

class MembersWidgetState extends State<MembersWidget> {
  final String appId;
  final String currentMemberId;

  MembersWidgetState(this.appId, this.currentMemberId);

  static EliudQuery? getQuery(String memberId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition('followedId', isEqualTo: memberId),
    ]);
  }

  Widget widgetProvider(String appId, FollowingModel value) {
    return FollowingDashboardItem(
        selectedMember: widget.selectedMember,
        currentMemberId: currentMemberId,
        appId: appId,
        value: value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowingListBloc>(
        create: (context) => FollowingListBloc(
              eliudQuery: getQuery(widget.currentMemberId),
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
  final SelectedMember selectedMember;
  final String currentMemberId;
  final FollowingModel? value;
  final String? appId;

  const FollowingDashboardItem({
    Key? key,
    required this.selectedMember,
    required this.currentMemberId,
    required this.value,
    this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Navigator.of(context).pop();
          selectedMember(value!.follower!.documentID!);
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
