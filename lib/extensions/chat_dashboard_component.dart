import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:bloc/bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:flutter/cupertino.dart';

import 'chat/room_list_widget.dart';

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
    var accessState = AccessBloc.getState(context);
    if (accessState is AppLoaded) {
      var appId = value!.appId;
      if (accessState.getMember() != null) {
        var memberId = accessState.getMember()!.documentID!;
        var eliudQuery = EliudQuery()
            .withCondition(EliudQueryCondition('appId', isEqualTo: appId))
            .withCondition(EliudQueryCondition('members',
            arrayContains: memberId));
        return BlocProvider(
          create: (_) =>
          RoomListBloc(
              orderBy: 'timestamp',
              descending: true,
              eliudQuery: eliudQuery,
              roomRepository: roomRepository(appId: appId)!)
            ..add(LoadRoomList()),
          child: const RoomListWidget(),
        );
      } else {
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .textStyle().text(context, 'No rooms available. Log on first');
      }
    } else {
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .progressIndicatorStyle()
          .progressIndicator(context);
    }
  }
}
