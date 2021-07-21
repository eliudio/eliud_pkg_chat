import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_pkg_chat/model/chat_entity.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/extensions/chat/chat.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/members_widget.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import 'bloc/chat_bloc.dart';
import 'bloc/chat_event.dart';
import 'bloc/chat_state.dart';

class ChatPage extends StatefulWidget {
  final String appId;
  final String roomId;
  final String memberId;
  final List<String> readAccess;

  const ChatPage({
    Key? key, required this.appId, required this.roomId, required this.memberId, required this.readAccess,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  EliudQuery getEliudQuery() {
    return EliudQuery()
        .withCondition(EliudQueryCondition('readAccess', arrayContains: widget.memberId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc >(
      create: (context) => ChatBloc(widget.memberId, widget.appId, widget.roomId, widget.readAccess, getEliudQuery(), chatRepository: chatRepository(appId: widget.appId, roomId: widget.roomId)!,

      )..add(ChatFetched()),

      child:     ChatWidget(appId: widget.appId, roomId: widget.roomId, memberId: widget.memberId, readAccess: widget.readAccess,)
    );
  }
}

class ChatWidget extends StatefulWidget {
  final String appId;
  final String roomId;
  final String memberId;
  final List<String> readAccess;

  const ChatWidget({
    Key? key, required this.appId, required this.roomId, required this.memberId, required this.readAccess,
  }) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  EliudQuery getEliudQuery(String chatId) {
    return EliudQuery()
        .withCondition(EliudQueryCondition('chatId', isEqualTo: chatId))
        .withCondition(EliudQueryCondition('readAccess', arrayContainsAny: [widget.memberId]));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatState) {
        List<Widget> widgets = [];
        for (int i = 0; i < state.values.length; i++) {
          widgets.add(Text(state.values[i]!.saying!));
        }
        widgets.add(_buttonNextPage(!state.hasReachedMax));
        return ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: widgets);      }
      return StyleRegistry.registry().styleWithContext(context)
          .frontEndStyle().progressIndicatorStyle().progressIndicator(context);
    });
  }

  Widget _buttonNextPage(bool mightHaveMore) {
    if (mightHaveMore) {
      return MyButton(
        onClickFunction: _onClick,
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Divider(
                height: 5,
              );
            } else {
              return Center(
                  child: StyleRegistry.registry()
                      .styleWithContext(context)
                      .frontEndStyle()
                      .textStyle()
                      .h5(
                    context,
                    "That's all folks",
                  ));
            }
          });
    }
  }

  void _onClick() {
    BlocProvider.of<ChatBloc>(context).add(ChatFetched());
  }
}

class MyButton extends StatefulWidget {
  //final RgbModel? buttonColor;
  final VoidCallback? onClickFunction;

  const MyButton({Key? key, /*this.buttonColor, */ this.onClickFunction})
      : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late bool clicked;

  @override
  void initState() {
    super.initState();
    clicked = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!clicked) {
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .buttonStyle()
          .button(
        context,
        label: 'More...',
        onPressed: () {
          setState(() {
            clicked = true;
          });
          widget.onClickFunction!();
        },
      );
    } else {
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .progressIndicatorStyle()
          .progressIndicator(context);
    }
  }
}
