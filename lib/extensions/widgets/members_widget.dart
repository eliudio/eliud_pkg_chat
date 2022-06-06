import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
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
  final AppModel app;
  final String currentMemberId;
  final SelectedMember selectedMember;

  const MembersWidget({
    required this.app,
    required this.currentMemberId,
    required this.selectedMember,
    Key? key,
  }) : super(key: key);

  @override
  MembersWidgetState createState() =>
      MembersWidgetState();
}

class MembersWidgetState extends State<MembersWidget> {
  MembersWidgetState();

  static EliudQuery? getQuery(String memberId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition('followedId', isEqualTo: memberId),
    ]);
  }

  Widget widgetProvider(AppModel app, FollowingModel value) {
    return FollowingDashboardItem(
        selectedMember: widget.selectedMember,
        currentMemberId: widget.currentMemberId,
        app: app,
        value: value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowingListBloc>(
        create: (context) => FollowingListBloc(
              eliudQuery: getQuery(widget.currentMemberId),
              detailed: true,
              followingRepository: followingRepository(appId: widget.app.documentID)!,
            )..add(LoadFollowingList()),
        child: FollowingListWidget(app: widget.app,
            readOnly: true,
            widgetProvider: (value) => widgetProvider(widget.app, value!),
            listBackground: BackgroundModel()));
  }
}

class FollowingDashboardItem extends StatelessWidget {
  final SelectedMember selectedMember;
  final String currentMemberId;
  final FollowingModel? value;
  final AppModel app;

  const FollowingDashboardItem({
    Key? key,
    required this.selectedMember,
    required this.currentMemberId,
    required this.value,
    required this.app,
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
          selectedMember(value!.follower!.documentID);
        },
        leading: const Icon(Icons.chat_bubble_outline),
        trailing: Container(
          height: 100,
          width: 100,
          child: photo,
        ),
        title: text(app,
                  context,
                  name,
                ));
  }
}
