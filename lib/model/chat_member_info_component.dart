/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';

import 'package:eliud_pkg_chat/model/chat_member_info_component_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_repository.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_component_state.dart';

abstract class AbstractChatMemberInfoComponent extends StatelessWidget {
  static String componentName = "chatMemberInfos";
  final String? chatMemberInfoID;

  AbstractChatMemberInfoComponent({Key? key, this.chatMemberInfoID}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatMemberInfoComponentBloc> (
          create: (context) => ChatMemberInfoComponentBloc(
            chatMemberInfoRepository: getChatMemberInfoRepository(context))
        ..add(FetchChatMemberInfoComponent(id: chatMemberInfoID)),
      child: _chatMemberInfoBlockBuilder(context),
    );
  }

  Widget _chatMemberInfoBlockBuilder(BuildContext context) {
    return BlocBuilder<ChatMemberInfoComponentBloc, ChatMemberInfoComponentState>(builder: (context, state) {
      if (state is ChatMemberInfoComponentLoaded) {
        if (state.value == null) {
          return alertWidget(title: 'Error', content: 'No ChatMemberInfo defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is ChatMemberInfoComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ChatMemberInfoComponentError) {
        return alertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, ChatMemberInfoModel? value);
  Widget alertWidget({ title: String, content: String});
  ChatMemberInfoRepository getChatMemberInfoRepository(BuildContext context);
}

