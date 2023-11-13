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

import 'package:eliud_pkg_chat/model/chat_member_info_component_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_component_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/model/app_model.dart';

/*
 * AbstractChatMemberInfoComponent is the base class to extend / implement in case you need to implement a component
 */
abstract class AbstractChatMemberInfoComponent extends StatelessWidget {
  static String componentName = "chatMemberInfos";
  final AppModel app;
  final String chatMemberInfoId;

  /*
   * Construct AbstractChatMemberInfoComponent
   */
  AbstractChatMemberInfoComponent(
      {super.key, required this.app, required this.chatMemberInfoId});

  /*
   * build the component
   */
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatMemberInfoComponentBloc>(
      create: (context) => ChatMemberInfoComponentBloc(
          chatMemberInfoRepository:
              chatMemberInfoRepository(appId: app.documentID)!)
        ..add(FetchChatMemberInfoComponent(id: chatMemberInfoId)),
      child: _chatMemberInfoBlockBuilder(context),
    );
  }

  Widget _chatMemberInfoBlockBuilder(BuildContext context) {
    return BlocBuilder<ChatMemberInfoComponentBloc,
        ChatMemberInfoComponentState>(builder: (context, state) {
      if (state is ChatMemberInfoComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is ChatMemberInfoComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is ChatMemberInfoComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry()
              .styleWithApp(app)
              .frontEndStyle()
              .progressIndicatorStyle()
              .progressIndicator(app, context),
        );
      }
    });
  }

  /*
   * Implement this method to provide your widget
   */
  Widget yourWidget(BuildContext context, ChatMemberInfoModel value);
}
