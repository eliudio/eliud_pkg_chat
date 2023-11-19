/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_chat/model/chat_component_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';
import 'package:eliud_pkg_chat/model/chat_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core_model/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_model/widgets/alert_widget.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core_model/model/app_model.dart';

/*
 * AbstractChatComponent is the base class to extend / implement in case you need to implement a component
 */
abstract class AbstractChatComponent extends StatelessWidget {
  static String componentName = "chats";
  final AppModel app;
  final String chatId;

  /*
   * Construct AbstractChatComponent
   */
  AbstractChatComponent({Key? key, required this.app, required this.chatId}): super(key: key);

  /*
   * build the component
   */
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatComponentBloc> (
          create: (context) => ChatComponentBloc(
            chatRepository: chatRepository(appId: app.documentID)!)
        ..add(FetchChatComponent(id: chatId)),
      child: _chatBlockBuilder(context),
    );
  }

  Widget _chatBlockBuilder(BuildContext context) {
    return BlocBuilder<ChatComponentBloc, ChatComponentState>(builder: (context, state) {
      if (state is ChatComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is ChatComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ChatComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  /*
   * Implement this method to provide your widget
   */
  Widget yourWidget(BuildContext context, ChatModel value);
}

