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
import 'package:eliud_pkg_chat/model/member_has_chat_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/app_model.dart';

abstract class AbstractMemberHasChatComponent extends StatelessWidget {
  static String componentName = "memberHasChats";
  final AppModel app;
  final String memberHasChatId;

  const AbstractMemberHasChatComponent({Key? key, required this.app, required this.memberHasChatId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MemberHasChatComponentBloc> (
          create: (context) => MemberHasChatComponentBloc(
            memberHasChatRepository: memberHasChatRepository(appId: app.documentID)!)
        ..add(FetchMemberHasChatComponent(id: memberHasChatId)),
      child: _memberHasChatBlockBuilder(context),
    );
  }

  Widget _memberHasChatBlockBuilder(BuildContext context) {
    return BlocBuilder<MemberHasChatComponentBloc, MemberHasChatComponentState>(builder: (context, state) {
      if (state is MemberHasChatComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is MemberHasChatComponentPermissionDenied) {
        return const Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is MemberHasChatComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, MemberHasChatModel value);
}

