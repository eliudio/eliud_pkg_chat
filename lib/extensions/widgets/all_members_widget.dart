import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_public_info_list.dart';
import 'package:eliud_core/model/member_public_info_list_bloc.dart';
import 'package:eliud_core/model/member_public_info_list_event.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/extensions/widgets/selected_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

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
class AllMembersWidget extends StatefulWidget {
  final AppModel app;
  final String currentMemberId;
  final SelectedMember selectedMember;

  const AllMembersWidget({
    required this.app,
    required this.currentMemberId,
    required this.selectedMember,
    Key? key,
  }) : super(key: key);

  @override
  AllMembersWidgetState createState() =>
      AllMembersWidgetState();
}

class AllMembersWidgetState extends State<AllMembersWidget> {
  AllMembersWidgetState();

  Widget widgetProvider(AppModel app, MemberPublicInfoModel value) {
    return MemberPublicInfoDashboardItem(
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
              memberPublicInfoRepository: memberPublicInfoRepository(appId: widget.app.documentID)!,
            )..add(LoadMemberPublicInfoList()),
        child: MemberPublicInfoListWidget(app: widget.app,
            readOnly: true,
            widgetProvider: (value) => widgetProvider(widget.app, value!),
            listBackground: BackgroundModel()));
  }
}

class MemberPublicInfoDashboardItem extends StatelessWidget {
  final SelectedMember selectedMember;
  final String currentMemberId;
  final MemberPublicInfoModel? value;
  final AppModel app;

  const MemberPublicInfoDashboardItem({
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
        title: text(app,
                  context,
                  name,
                ));
  }
}
