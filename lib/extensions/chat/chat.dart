import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';


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
  @override
  Widget build(BuildContext context) {
    var eliudQuery = EliudQuery()
        .withCondition(EliudQueryCondition('readAccess', arrayContains: widget.memberId));
    return BlocProvider<ChatListBloc>(
      create: (context) => ChatListBloc(paged: true, orderBy: 'timestamp', descending: true, detailed: true, eliudQuery: eliudQuery,
        chatRepository: chatRepository(appId: widget.appId, roomId: widget.roomId)!,
      )..add(LoadChatList()),
        child:     ChatWidget(appId: widget.appId, roomId: widget.roomId, memberId: widget.memberId, readAccess: widget.readAccess,)
    );

    /*
    return BlocProvider<ChatBloc >(
        create: (context) => ChatBloc(widget.memberId, widget.appId, widget.roomId, widget.readAccess, chatRepository: chatRepository(appId: widget.appId, roomId: widget.roomId)!,
        )..add(ChatFetched()),
        child:     ChatWidget(appId: widget.appId, roomId: widget.roomId, memberId: widget.memberId, readAccess: widget.readAccess,)
    );
*/
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
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ChatListBloc, ChatListState>(builder: (context, state) {
      if (state is ChatListState) {
        if (state is ChatListLoaded) {
          List<Widget> widgets = [];
          for (int i = 0; i < state.values!.length; i++) {
            widgets.add(Text(state.values![i]!.saying!));
          }
          widgets.add(buttonAdd());
          widgets.add(_buttonNextPage(state.mightHaveMore!));
          return ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: widgets);
        }
      }
      return StyleRegistry.registry().styleWithContext(context)
          .frontEndStyle().progressIndicatorStyle().progressIndicator(context);
    });
  }

  Widget buttonAdd() {
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .buttonStyle()
        .button(
      context,
      label: 'Say something ',
      onPressed: () {
        BlocProvider.of<ChatListBloc>(context).add(AddChatList(value: ChatModel(
          documentID: newRandomKey(),
          appId: widget.appId,
          roomId: widget.roomId,
          authorId: widget.memberId,
          readAccess: widget.readAccess,
          saying: 'Lalalal ' + newRandomKey(),
        )));
      },
    );
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
    BlocProvider.of<ChatListBloc>(context).add(NewPage());
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
