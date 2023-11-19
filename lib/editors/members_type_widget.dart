import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/style/frontend/has_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/chat_dashboard_model.dart';

typedef MembersTypeCallback = Function(MembersType membersType);

class MembersTypeWidget extends StatefulWidget {
  final MembersTypeCallback membersTypeCallback;
  final MembersType membersType;
  final AppModel app;

  MembersTypeWidget(
      {super.key,
      required this.app,
      required this.membersTypeCallback,
      required this.membersType});

  @override
  State<StatefulWidget> createState() {
    return _MembersTypeWidgetState();
  }
}

class _MembersTypeWidgetState extends State<MembersTypeWidget> {
  int? _heightTypeSelectedRadioTile;

  @override
  void initState() {
    super.initState();
    _heightTypeSelectedRadioTile = widget.membersType.index;
  }

  String heighttTypeLandscapeStringValue(MembersType? membersType) {
    switch (membersType) {
      case MembersType.followingMembers:
        return 'Following members';
      case MembersType.allMembers:
        return 'All members';
      case MembersType.unknown:
        break;
      case null:
        break;
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
    if (membersType == null) return const Text("?");
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
    return ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          getPrivilegeOption(MembersType.allMembers),
          getPrivilegeOption(MembersType.followingMembers)
        ]);
  }
}
