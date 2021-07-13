import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';
import 'package:flutter/cupertino.dart';

import 'chat/dashboard_widget.dart';

class ChatDashboardComponentConstructorDefault implements ComponentConstructor {
  @override
  Widget createNew({String? id, Map<String, dynamic>? parameters}) {
    return ChatDashboard(id: id);
  }
}

class ChatDashboard extends AbstractChatDashboardComponent {
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
    return DashboardWidget();
  }
}
