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
import 'package:eliud_pkg_chat/model/chat_dashboard_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/app_model.dart';

abstract class AbstractChatDashboardComponent extends StatelessWidget {
  static String componentName = "chatDashboards";
  final AppModel app;
  final String chatDashboardId;

  AbstractChatDashboardComponent(
      {super.key, required this.app, required this.chatDashboardId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatDashboardComponentBloc>(
      create: (context) => ChatDashboardComponentBloc(
          chatDashboardRepository:
              chatDashboardRepository(appId: app.documentID)!)
        ..add(FetchChatDashboardComponent(id: chatDashboardId)),
      child: _chatDashboardBlockBuilder(context),
    );
  }

  Widget _chatDashboardBlockBuilder(BuildContext context) {
    return BlocBuilder<ChatDashboardComponentBloc, ChatDashboardComponentState>(
        builder: (context, state) {
      if (state is ChatDashboardComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is ChatDashboardComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ChatDashboardComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(app)
              .frontEndStyle()
              .progressIndicatorStyle()
              .progressIndicator(app, context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, ChatDashboardModel value);
}
