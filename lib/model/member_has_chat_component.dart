/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_chat/model/member_has_chat_component_bloc.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_component_event.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_model.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_repository.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

abstract class AbstractMemberHasChatComponent extends StatelessWidget {
  static String componentName = "memberHasChats";
  final String theAppId;
  final String memberHasChatId;

  AbstractMemberHasChatComponent({Key? key, required this.theAppId, required this.memberHasChatId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MemberHasChatComponentBloc> (
          create: (context) => MemberHasChatComponentBloc(
            memberHasChatRepository: memberHasChatRepository(appId: theAppId)!)
        ..add(FetchMemberHasChatComponent(id: memberHasChatId)),
      child: _memberHasChatBlockBuilder(context),
    );
  }

  Widget _memberHasChatBlockBuilder(BuildContext context) {
    return BlocBuilder<MemberHasChatComponentBloc, MemberHasChatComponentState>(builder: (context, state) {
      if (state is MemberHasChatComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(title: "Error", content: 'No MemberHasChat defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is MemberHasChatComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is MemberHasChatComponentError) {
        return AlertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, MemberHasChatModel value);
}

