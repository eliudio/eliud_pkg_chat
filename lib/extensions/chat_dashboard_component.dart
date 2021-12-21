import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/extensions/widgets/all_chats_widget.dart';
import 'package:eliud_pkg_chat/extensions/widgets/bloc/all_chats_bloc.dart';
import 'package:eliud_pkg_chat/extensions/widgets/bloc/all_chats_event.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';

class ChatDashboardComponentConstructorDefault implements ComponentConstructor {
  @override
  Widget createNew({Key? key, required String appId, required String id, Map<String, dynamic>? parameters}) {
    return ChatDashboard(key: key, appId: appId, id: id);
  }

  @override
  Future<dynamic> getModel({required String appId, required String id}) async => await chatDashboardRepository(appId: appId)!.get(id);
}

class ChatDashboard extends AbstractChatDashboardComponent {
  static double HEADER_HEIGHT = 155;

  ChatDashboard({Key? key, required String appId, required String id}) : super(key: key, theAppId: appId, chatDashboardId: id);

  @override
  Widget yourWidget(BuildContext context, ChatDashboardModel? value) {
    var accessState = AccessBloc.getState(context);
    if (accessState is AccessDetermined) {
      var appId = accessState.currentApp.documentID!;
      if (accessState.getMember() != null) {
        var memberId = accessState.getMember()!.documentID!;
        var eliudQuery = EliudQuery()
            .withCondition(EliudQueryCondition('appId', isEqualTo: appId))
            .withCondition(
            EliudQueryCondition('members', arrayContains: memberId));

        return SizedBox(
            height:
            MediaQuery.of(context).size.height,
            width: double.infinity,
            child: BlocProvider(
                create: (_) => AllChatsBloc(
                    thisMemberId: memberId,
                    orderBy: 'timestamp',
                    descending: true,
                    eliudQuery: eliudQuery,
                    roomRepository: roomRepository(appId: appId)!)
                  ..add(LoadAllChats()),
                child: AllChatsWidget(appId: appId, memberId: memberId)));
      } else {
        return const Text('Member not available');
      }
    } else {
      return const Text('App not loaded');
    }
  }
}
