/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_pkg_chat/model/chat_interactions_component_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_model.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_repository.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_component_state.dart';

abstract class AbstractChatInteractionsComponent extends StatelessWidget {
  static String componentName = "chatInteractionss";
  final String? chatInteractionsID;

  AbstractChatInteractionsComponent({this.chatInteractionsID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatInteractionsComponentBloc> (
          create: (context) => ChatInteractionsComponentBloc(
            chatInteractionsRepository: getChatInteractionsRepository(context))
        ..add(FetchChatInteractionsComponent(id: chatInteractionsID)),
      child: _chatInteractionsBlockBuilder(context),
    );
  }

  Widget _chatInteractionsBlockBuilder(BuildContext context) {
    return BlocBuilder<ChatInteractionsComponentBloc, ChatInteractionsComponentState>(builder: (context, state) {
      if (state is ChatInteractionsComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No ChatInteractions defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is ChatInteractionsComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ChatInteractionsComponentError) {
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, ChatInteractionsModel? value);
  Widget alertWidget({ title: String, content: String});
  ChatInteractionsRepository getChatInteractionsRepository(BuildContext context);
}

