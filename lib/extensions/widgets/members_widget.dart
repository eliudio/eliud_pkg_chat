import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/decoration_color_model.dart';
import 'package:eliud_core/model/rgb_model.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
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
  final List<String> blockedMembers;

  const MembersWidget({
    required this.app,
    required this.currentMemberId,
    required this.selectedMember,
    required this.membersType,
    required this.blockedMembers,
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
        blockedMembers: widget.blockedMembers,
        app: widget.app,
        currentMemberId: widget.currentMemberId,
        selectedMember: widget.selectedMember,
      );
    } else {
      return _AllMembersWidget(
        blockedMembers: widget.blockedMembers,
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
  final List<String> blockedMembers;

  const _AllMembersWidget({
    required this.blockedMembers,
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

  List<MemberPublicInfoModel> filterBlocked(List<MemberPublicInfoModel?> values) {
    List<MemberPublicInfoModel> members = [];
    for (var element in values) {
      if ((element != null) && (element.documentID != null)) {
        var memberId = element.documentID;
        if ((memberId != widget.currentMemberId) && (!widget.blockedMembers.contains(memberId))) {
          members.add(element);
        }
      }
    }
    return members;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MemberPublicInfoListBloc>(
        create: (context) => MemberPublicInfoListBloc(
              filter: (values) => filterBlocked(values),
              detailed: true,
              memberPublicInfoRepository:
                  memberPublicInfoRepository(appId: widget.app.documentID)!,
            )..add(LoadMemberPublicInfoList()),
        child: MemberPublicInfoListWidget(
            app: widget.app,
            readOnly: true,
            widgetProvider: (value) => widgetProvider(widget.app, value!),
            // transparent bg
            listBackground: BackgroundModel(decorationColors: [DecorationColorModel(
                documentID: 'N/A',
                color: RgbModel(r: 0, g: 0, b: 0, opacity: 0.0),
              stop: 0,
            )])));
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
    Widget photo;
    String name;
    if ((data == null) || (data.photoURL == null)) {
      name = 'No name';
      photo = const Icon(Icons.person);
    } else {
      photo = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: data.photoURL!,
      );
      name = (data.name != null && data.name!.isNotEmpty) ? data.name! : 'No name';
    }
    return getListTile(context, app,
/*
        onTap,
          Widget? leading,
          Widget? trailing,
          Widget? title,
          Widget? subtitle,
          bool? isThreeLine}) =>


    return ListTile(
*/
        onTap: () async {
          Navigator.of(context).pop();
          selectedMember(value!.documentID);
        },
        leading: const Icon(Icons.chat_bubble_outline),
        trailing: SizedBox(
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
  final List<String> blockedMembers;

  const _FollowingMembersWidget({
    required this.blockedMembers,
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

  List<FollowingModel> filterBlocked(List<FollowingModel?> values) {
    List<FollowingModel> following = [];
    for (var element in values) {
      if ((element != null) && (element.followed != null)) {
        var memberId = element.followed!.documentID;
        if ((memberId != widget.currentMemberId) && (!widget.blockedMembers.contains(memberId))) {
          following.add(element);
        }
      }
    }
    return following;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowingListBloc>(
        create: (context) => FollowingListBloc(
              //filter: (values) => filterBlocked(values),
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
    Widget photo;
    String name;
    if ((data == null) || (data.photoURL == null)) {
      name = 'No name';
      photo = const Icon(Icons.person);
    } else {
      photo = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: data.photoURL!,
      );
      name = (data.name != null && data.name!.isNotEmpty) ? data.name! : 'No name';
    }
    return ListTile(
        onTap: () async {
          Navigator.of(context).pop();
          selectedMember(value!.follower!.documentID);
        },
        leading: const Icon(Icons.chat_bubble_outline),
        trailing: SizedBox(
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
