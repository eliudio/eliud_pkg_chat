import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/style/frontend/has_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/chat_dashboard_model.dart';

typedef MembersTypeCallback = Function(
    MembersType membersType);

class MembersTypeWidget extends StatefulWidget {
  MembersTypeCallback membersTypeCallback;
  final MembersType membersType;
  final AppModel app;
  MembersTypeWidget(
      {Key? key,
        required this.app,
        required this.membersTypeCallback,
        required this.membersType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MembersTypeWidgetState();
  }
}

class _MembersTypeWidgetState extends State<MembersTypeWidget> {
  int? _heightTypeSelectedRadioTile;

  void initState() {
    super.initState();
    _heightTypeSelectedRadioTile = widget.membersType.index;
  }

  String heighttTypeLandscapeStringValue(MembersType? membersType) {
    switch (membersType) {
      case MembersType.FollowingMembers:
        return 'Following members';
      case MembersType.AllMembers:
        return 'All members';
    }
    return '?';
  }

  void setSelection(int? val) {
    setState(() {
      _heightTypeSelectedRadioTile = val;
      widget.membersTypeCallback(toMembersType(val));
    });
  }

  Widget getPrivilegeOption(MembersType? membersType) {
    if (membersType == null) return Text("?");
    var stringValue = heighttTypeLandscapeStringValue(membersType);
    return Center(
        child: radioListTile(
            widget.app,
            context,
            membersType.index,
            _heightTypeSelectedRadioTile,
            stringValue,
            null,
                (dynamic val) => setSelection(val)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
      getPrivilegeOption(MembersType.AllMembers),
      getPrivilegeOption(MembersType.FollowingMembers)
    ]);
  }
}
