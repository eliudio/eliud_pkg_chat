import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/component_constructor.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:flutter/cupertino.dart';

class ChatDashboardComponentConstructorDefault
    implements ComponentConstructor {

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
    // We show the list of recent conversations, i.e. query Chat reversed order of timestamp
    //       By the way, when updating ChatInteractions, we must also update Cchat
    // Here
    //   we can select a conversation and continue the conversation
    //   we can create a conversation, for 1 member (follower), or with a list of members (group).
    //     The people in the chat should become part of chat::members and also appear as readAccess
    //     The person chatting is the author in chatconversation
    //     The person(s) being talked to become part of readAccess
    //
    // In the conversation itself, we show the conversation like: https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
    //
    // Rules:
    // chatdashboard: same as chat now, like feeddashboard and stuff, ... I.e. member can create
    // chat and chatconversation: base on post
    //
    return Text("Here comes the chat");
  }

}
