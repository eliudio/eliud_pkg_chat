import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';

import 'dashboard/bloc/chat_dashboard_bloc.dart';
import 'dashboard/bloc/chat_dashboard_event.dart';
import 'dashboard/dashboard_widget.dart';

class ChatDashboardComponentConstructorDefault implements ComponentConstructor {
  @override
  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return ChatDashboard(id: id);
  }
}

class ChatDashboard extends AbstractChatDashboardComponent {
  static double HEADER_HEIGHT =  155;

  ChatDashboard({String? id}) : super(chatDashboardID: id);

  @override
  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(title: title, content: content);
  }

  @override
  ChatDashboardRepository getChatDashboardRepository(BuildContext context) {
    return chatDashboardRepository(appId: AccessBloc.appId(context))!;
  }

  @override
  Widget yourWidget(BuildContext context, ChatDashboardModel? value) {
    var accessState = AccessBloc.getState(context);
    if (accessState is AppLoaded) {
      var appId = accessState.app.documentID;
      if (accessState.getMember() != null) {
        var memberId = accessState.getMember()!.documentID!;

        return SizedBox(height: MediaQuery.of(context).size.height -ChatDashboard.HEADER_HEIGHT, child: BlocProvider<ChatDashboardBloc>(
            create: (context) => ChatDashboardBloc(appId!)..add(OpenMemberRoomsWidgetEvent()),
            child: DashboardWidget(appId: appId!, memberId: memberId)));
      } else {
        return const Text('Member not available');
      }
    } else {
      return const Text('App not loaded');
    }
  }
}
