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
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

abstract class AbstractChatComponent extends StatelessWidget {
  static String componentName = "chats";
  final String theAppId;
  final String chatId;

  AbstractChatComponent({Key? key, required this.theAppId, required this.chatId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatComponentBloc> (
          create: (context) => ChatComponentBloc(
            chatRepository: chatRepository(appId: theAppId)!)
        ..add(FetchChatComponent(id: chatId)),
      child: _chatBlockBuilder(context),
    );
  }

  Widget _chatBlockBuilder(BuildContext context) {
    return BlocBuilder<ChatComponentBloc, ChatComponentState>(builder: (context, state) {
      if (state is ChatComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(title: "Error", content: 'No Chat defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is ChatComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ChatComponentError) {
        return AlertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, ChatModel value);
}

