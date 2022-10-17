import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_pkg_chat/extensions/widgets/selected_member.dart';
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
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_public_info_list.dart';
import 'package:eliud_core/model/member_public_info_list_bloc.dart';
import 'package:eliud_core/model/member_public_info_list_event.dart';
import 'package:eliud_core/model/member_public_info_model.dart';

import '../../model/chat_dashboard_model.dart';

class MembersWidget extends StatefulWidget {
  final AppModel app;
  final String currentMemberId;
  final SelectedMember selectedMember;
  final MembersType? membersType;

  const MembersWidget({
    required this.app,
    required this.currentMemberId,
    required this.selectedMember,
    required this.membersType,
    Key? key,
  }) : super(key: key);

  @override
  MembersWidgetState createState() => MembersWidgetState();
}

class MembersWidgetState extends State<MembersWidget> {
  @override
  Widget build(BuildContext context) {
    if ((widget.membersType == null) ||
        (widget.membersType == MembersType.FollowingMembers)) {
      return _FollowingMembersWidget(
        app: widget.app,
        currentMemberId: widget.currentMemberId,
        selectedMember: widget.selectedMember,
      );
    } else {
      return _AllMembersWidget(
        app: widget.app,
        currentMemberId: widget.currentMemberId,
        selectedMember: widget.selectedMember,
      );
    }
  }
}

class _AllMembersWidget extends StatefulWidget {
  final AppModel app;
  final String currentMemberId;
  final SelectedMember selectedMember;

  const _AllMembersWidget({
    required this.app,
    required this.currentMemberId,
    required this.selectedMember,
    Key? key,
  }) : super(key: key);

  @override
  _AllMembersWidgetState createState() => _AllMembersWidgetState();
}

class _AllMembersWidgetState extends State<_AllMembersWidget> {
  _AllMembersWidgetState();

  Widget widgetProvider(AppModel app, MemberPublicInfoModel value) {
    return _MemberPublicInfoDashboardItem(
        selectedMember: widget.selectedMember,
        currentMemberId: widget.currentMemberId,
        app: app,
        value: value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MemberPublicInfoListBloc>(
        create: (context) => MemberPublicInfoListBloc(
              detailed: true,
              memberPublicInfoRepository:
                  memberPublicInfoRepository(appId: widget.app.documentID)!,
            )..add(LoadMemberPublicInfoList()),
        child: MemberPublicInfoListWidget(
            app: widget.app,
            readOnly: true,
            widgetProvider: (value) => widgetProvider(widget.app, value!),
            listBackground: BackgroundModel()));
  }
}

class _MemberPublicInfoDashboardItem extends StatelessWidget {
  final SelectedMember selectedMember;
  final String currentMemberId;
  final MemberPublicInfoModel? value;
  final AppModel app;

  const _MemberPublicInfoDashboardItem({
    Key? key,
    required this.selectedMember,
    required this.currentMemberId,
    required this.value,
    required this.app,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = value!;
    var photo;
    var name;
    if ((data == null) || (data.photoURL == null)) {
      name = 'No name';
      photo = const Icon(Icons.person);
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
          selectedMember(value!.documentID);
        },
        leading: const Icon(Icons.chat_bubble_outline),
        trailing: Container(
          height: 100,
          width: 100,
          child: photo,
        ),
        title: text(
          app,
          context,
          name,
        ));
  }
}

class _FollowingMembersWidget extends StatefulWidget {
  final AppModel app;
  final String currentMemberId;
  final SelectedMember selectedMember;

  const _FollowingMembersWidget({
    required this.app,
    required this.currentMemberId,
    required this.selectedMember,
    Key? key,
  }) : super(key: key);

  @override
  _FollowingMembersWidgetState createState() => _FollowingMembersWidgetState();
}

class _FollowingMembersWidgetState extends State<_FollowingMembersWidget> {
  _FollowingMembersWidgetState();

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
              followingRepository:
                  followingRepository(appId: widget.app.documentID)!,
            )..add(LoadFollowingList()),
        child: FollowingListWidget(
            app: widget.app,
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
    if ((data == null) || (data.photoURL == null)) {
      name = 'No name';
      photo = const Icon(Icons.person);
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
        title: text(
          app,
          context,
          name,
        ));
  }
}
