/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_chat/model/chat_dashboard_component_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

abstract class AbstractChatDashboardComponent extends StatelessWidget {
  static String componentName = "chatDashboards";
  final String theAppId;
  final String chatDashboardId;

  AbstractChatDashboardComponent({Key? key, required this.theAppId, required this.chatDashboardId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatDashboardComponentBloc> (
          create: (context) => ChatDashboardComponentBloc(
            chatDashboardRepository: chatDashboardRepository(appId: theAppId)!)
        ..add(FetchChatDashboardComponent(id: chatDashboardId)),
      child: _chatDashboardBlockBuilder(context),
    );
  }

  Widget _chatDashboardBlockBuilder(BuildContext context) {
    return BlocBuilder<ChatDashboardComponentBloc, ChatDashboardComponentState>(builder: (context, state) {
      if (state is ChatDashboardComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(title: "Error", content: 'No ChatDashboard defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is ChatDashboardComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ChatDashboardComponentError) {
        return AlertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, ChatDashboardModel value);
}

