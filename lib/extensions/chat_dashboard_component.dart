import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/extensions/widgets/all_chats_bloc/all_chats_state.dart';
import 'package:eliud_pkg_chat/extensions/widgets/all_chats_widget.dart';
import 'package:eliud_pkg_chat/extensions/widgets/chat_bloc/chat_event.dart';
import 'package:eliud_pkg_chat/extensions/widgets/chat_widget.dart';
import '../model/room_model.dart';
import 'widgets/all_chats_bloc/all_chats_bloc.dart';
import 'widgets/all_chats_bloc/all_chats_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';

import 'widgets/chat_bloc/chat_bloc.dart';

class ChatDashboardComponentConstructorDefault implements ComponentConstructor {
  @override
  Widget createNew(
      {Key? key,
      required AppModel app,
      required String id,
      Map<String, dynamic>? parameters}) {
    return ChatDashboard(key: key, app: app, id: id);
  }

  @override
  Future<dynamic> getModel({required AppModel app, required String id}) async =>
      await chatDashboardRepository(appId: app.documentID)!.get(id);
}

class ChatDashboard extends AbstractChatDashboardComponent {
  static double HEADER_HEIGHT = 155;

  ChatDashboard({Key? key, required AppModel app, required String id})
      : super(key: key, app: app, chatDashboardId: id);

  @override
  Widget yourWidget(BuildContext context, ChatDashboardModel? value) {
    var accessState = AccessBloc.getState(context);
    if (accessState is AccessDetermined) {
      var appId = app.documentID;
      if (accessState.getMember() != null) {
        var memberId = accessState.getMember()!.documentID;
        var eliudQuery = EliudQuery()
            .withCondition(EliudQueryCondition('appId', isEqualTo: appId))
            .withCondition(
                EliudQueryCondition('members', arrayContains: memberId));
        var height = MediaQuery.of(context).size.height -
            kToolbarHeight -
            kBottomNavigationBarHeight;
        var chatBloc = ChatBloc(
          appId: appId,
          thisMemberId: memberId,
        );
        var allChatsBloc = AllChatsBloc(
            chatBloc: chatBloc,
            appId: appId,
            thisMemberId: memberId,
            orderBy: 'timestamp',
            descending: true,
            eliudQuery: eliudQuery,
            roomRepository: roomRepository(appId: appId)!)
          ..add(LoadAllChats());
        return SizedBox(
            height: height,
            width: double.infinity,
            child: MultiBlocProvider(
                providers: [
                  BlocProvider<AllChatsBloc>(create: (context) => allChatsBloc),
                  BlocProvider<ChatBloc>(create: (context) => chatBloc)
                ],
                child: AllChatsWidget(app: app,
                  memberId: memberId,
                )));
      } else {
        return const Text('Member not available');
      }
    } else {
      return const Text('App not loaded');
    }
  }

}
