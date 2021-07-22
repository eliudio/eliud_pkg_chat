import 'package:bubble/bubble.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  final String appId;
  final String roomId;
  final String memberId;
  final List<String> readAccess;
  final double height;

  const ChatPage({
    Key? key,
    required this.appId,
    required this.roomId,
    required this.memberId,
    required this.readAccess,
    required this.height,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var eliudQuery = EliudQuery().withCondition(
        EliudQueryCondition('readAccess', arrayContains: widget.memberId));
    return BlocProvider<ChatListBloc>(
        create: (context) => ChatListBloc(
              paged: true,
              orderBy: 'timestamp',
              descending: true,
              detailed: true,
              eliudQuery: eliudQuery,
              chatRepository:
                  chatRepository(appId: widget.appId, roomId: widget.roomId)!,
            )..add(LoadChatList()),
        child: ChatWidget(
            appId: widget.appId,
            roomId: widget.roomId,
            memberId: widget.memberId,
            readAccess: widget.readAccess,
            height: widget.height));

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
  final double height;

  const ChatWidget({
    Key? key,
    required this.appId,
    required this.roomId,
    required this.memberId,
    required this.readAccess,
    required this.height,
  }) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController controller1 = ScrollController();

  @override
  void initState() {
    super.initState();
    _gotoBottom();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListBloc, ChatListState>(builder: (context, state) {
      bool scrolling = false;
      if (state is ChatListState) {
        if (state is ChatListLoaded) {
          List<Widget> widgets = [];
          int len = state.values!.length;
          for (int i = 0; i < len; i++) {
            var saying;
            if (state.values![len - i - 1] != null) {
              ChatModel value = state.values![len - i - 1]!;
              var timestamp = value.timestamp;
              if (value.saying != null) {
                saying = value.saying!;
              } else {
                saying = 'Eek1 - This is an error';
              }
            } else {
              saying = 'Eek2 - This is an error';
            }
            widgets.add(Bubble(
              margin: const BubbleEdges.only(top: 10),
              alignment: Alignment.topRight,
              nip: BubbleNip.rightTop,
              color: const Color.fromRGBO(225, 255, 199, 1.0),
              child: Text(saying, textAlign: TextAlign.right),
            ),);
          }
          List<Widget> reorderedWidgets = [];
          reorderedWidgets.add(_buttonNextPage(state.mightHaveMore!));
          reorderedWidgets.addAll(widgets);
          var listWidget = ListView(
            controller: controller1,
              shrinkWrap: true,
//              physics: ScrollPhysics(),
              children: reorderedWidgets);
/*
          var widget1 = NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if ((!scrolling) &&
                    (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) &&
                    (scrollInfo.metrics.axisDirection == AxisDirection.down)) {
                  BlocProvider.of<ChatListBloc>(context).add(NewPage());
                  scrolling = true;
                }
                return false;
              },
              child: listWidget);
*/

          var allWidgets = [
            SizedBox(height: widget.height - 50, child: listWidget),
            _speakRow()
          ];
          return ListView(
              shrinkWrap: true,
//              physics: ScrollPhysics(),
              children: allWidgets);
        }
      }
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .progressIndicatorStyle()
          .progressIndicator(context);
    });
  }

  Widget _speakField() {
    return TextField(
      textAlign: TextAlign.left,
      controller: _commentController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Say something...',
        hintStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.only(left: 8),
        fillColor: Colors.grey,
      ),
    );
  }

  Widget _speakRow() {
    return Row(children: [
/*
      Container(
          height: 60, width: 60, child: avatar == null ? Container() : avatar),
      Container(width: 8),
*/
      Flexible(
        child: Container(
            alignment: Alignment.center, height: 30, child: _speakField()),
      ),
      Container(width: 8),
      Container(height:50, child: buttonAdd()),
    ]);
  }

  Widget buttonAdd() {
    var addIcon = Icon(Icons.more_horiz);
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .buttonStyle()
        .button(
      context,
      label: 'Ok',
      onPressed: () {
        if ((_commentController.text != null) &&
            (_commentController.text.length > 0)) {
          BlocProvider.of<ChatListBloc>(context).add(AddChatList(
              value: ChatModel(
            documentID: newRandomKey(),
            appId: widget.appId,
            roomId: widget.roomId,
            authorId: widget.memberId,
            readAccess: widget.readAccess,
            saying: _commentController.text,
          )));
          _commentController.clear();
          _gotoBottom();
        }
      },
    );
  }

  void _gotoBottom() {
    if (SchedulerBinding.instance != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        controller1.animateTo(
          controller1.position.maxScrollExtent,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,);
      });
    }
  }

  void _onClick() {
    BlocProvider.of<ChatListBloc>(context).add(NewPage());
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
  @override
  Widget build(BuildContext context) {
      return StyleRegistry.registry()
          .styleWithContext(context)
          .frontEndStyle()
          .buttonStyle()
          .button(
        context,
        label: 'More...',
        onPressed: () {
          widget.onClickFunction!();
        },
      );
  }
}
