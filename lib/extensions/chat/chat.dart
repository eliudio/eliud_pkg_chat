import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart' as ChatListEvent;
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart'
    as ChatMemberInfoListEvent;
import 'package:eliud_pkg_chat/model/chat_member_info_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/tools/indicate_read.dart';
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
  final List<String> members;
  late List<String> readAccess;
  final double height;
  final int selectedOptionBeforeChat;

  ChatPage({
    Key? key,
    required this.appId,
    required this.roomId,
    required this.memberId,
    required this.members,
    required this.height,
    required this.selectedOptionBeforeChat,
  }) : super(key: key) {
    readAccess = members;
  }

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var eliudQueryChatList = EliudQuery().withCondition(
        EliudQueryCondition('readAccess', arrayContains: widget.memberId));

    var otherMember;
    if (widget.members.length == 2) {
      // currently we support read-indication for 1 member only
      if (widget.members[0] == widget.memberId) {
        otherMember = widget.members[1];
      } else {
        otherMember = widget.members[0];
      }
    }

    var eliudQueryChatMemberInfoList = EliudQuery()
        .withCondition(EliudQueryCondition('appId', isEqualTo: widget.appId))
        .withCondition(EliudQueryCondition('roomId', isEqualTo: widget.roomId))
        .withCondition(EliudQueryCondition('authorId', isEqualTo: otherMember))
        .withCondition(
            EliudQueryCondition('readAccess', arrayContains: widget.memberId));

    return MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<ChatListBloc>(
              create: (context) => ChatListBloc(
                    paged: true,
                    orderBy: 'timestamp',
                    descending: true,
                    detailed: true,
                    eliudQuery: eliudQueryChatList,
                    chatLimit: 5,
                    chatRepository: chatRepository(
                        appId: widget.appId, roomId: widget.roomId)!,
                  )..add(ChatListEvent.LoadChatList())),
          BlocProvider<ChatMemberInfoListBloc>(
              create: (context) => ChatMemberInfoListBloc(
                    eliudQuery: eliudQueryChatMemberInfoList,
                    chatMemberInfoRepository: chatMemberInfoRepository(
                        appId: widget.appId, roomId: widget.roomId)!,
                  )..add(ChatMemberInfoListEvent.LoadChatMemberInfoList())),
        ],
        child: ChatWidget(
          appId: widget.appId,
          roomId: widget.roomId,
          memberId: widget.memberId,
          readAccess: widget.readAccess,
          height: widget.height,
          selectedOptionBeforeChat: widget.selectedOptionBeforeChat,
        ));

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
  final int selectedOptionBeforeChat;

  const ChatWidget({
    Key? key,
    required this.appId,
    required this.roomId,
    required this.memberId,
    required this.readAccess,
    required this.height,
    required this.selectedOptionBeforeChat,
  }) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController controller1 = ScrollController();
  bool requestedNewPage = false;

  String _roomName() {
    return 'room name';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? otherMemberLastRead;
    return BlocBuilder<ChatMemberInfoListBloc, ChatMemberInfoListState>(
        builder: (chatMemberInfoContext, chatMemberInfoState) {
      if (chatMemberInfoState is ChatMemberInfoListLoaded) {
        if ((chatMemberInfoState.values != null) &&
            (chatMemberInfoState.values!.isNotEmpty)) {
          var value = chatMemberInfoState.values![0];
          if ((value != null) && (value.timestamp != null)) {
            otherMemberLastRead = dateTimeFromTimestampString(value.timestamp!);
          }
        }
      }
      return BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
        if (state is ChatListState) {
          if (state is ChatListLoaded) {
            List<Widget> widgets = [];
            int len = state.values!.length;
            DateTime? oldDate;
            String saying;
            var itsMe = true;
            String? timeString = null;
            var lastRead; // what's the last item I've just read?
            for (int i = 0; i < len; i++) {
              var newDate;
              var hasRead = false; // did the other member read the message yet?
              if (state.values![len - i - 1] != null) {
                ChatModel value = state.values![len - i - 1]!;
                itsMe = value.authorId == widget.memberId;
                var timestamp = value.timestamp;
                if (value.saying == null) {
                  saying = 'Eek 1a - This is an error';
                } else {
                  saying = value.saying!;
                  if ((timestamp == 'null') || (timestamp == null)) {
                    newDate = DateTime.now();
                    timeString = 'Now';
                  } else {
                    newDate = dateFromTimestampString(timestamp);
                    DateTime newDateTime = dateTimeFromTimestampString(timestamp);
                    timeString = formatHHMM(newDateTime);
                    if ((itsMe) && ((otherMemberLastRead != null) &&
                          (otherMemberLastRead!.compareTo(newDateTime) >= 0))) {
                      hasRead = true;
                    }
                    lastRead = value;
                  }
                }
              } else {
                saying = 'Eek2 - This is an error';
              }
              if ((oldDate == null) || !isSameDate(newDate, oldDate)) {
                widgets.add(Center(
                    child: DateChip(
                  date: newDate,
                  color: const Color(0x558AD3D5),
                )));
              }
              oldDate = newDate;
              widgets.add(
                BubbleSpecialOne(
                    text: saying,
                    isSender: itsMe,
                    sent: itsMe,
                    seen: hasRead,
                    color: Colors.white, //const Color(0xFF1B97F3),
                    time: timeString,
                    textStyle: StyleRegistry.registry()
                        .styleWithContext(context)
                        .frontEndStyle()
                        .textStyleStyle()
                        .styleText(context)!,
                    timeTextStyle: StyleRegistry.registry()
                      .styleWithContext(context)
                      .frontEndStyle()
                      .textStyleStyle()
                      .styleSmallText(context)!
                ),
              );
            }
            IndicateRead.setRead(widget.appId, widget.roomId, widget.memberId,
                lastRead, widget.readAccess);
            List<Widget> reorderedWidgets = [];
            reorderedWidgets.add(_buttonNextPage(state.mightHaveMore!));
            reorderedWidgets.addAll(widgets);
            var listWidget = ListView(
                controller: controller1,
                shrinkWrap: true,
                children: reorderedWidgets);
            if (!requestedNewPage) {
              _gotoBottom();
            }
            requestedNewPage = false;
            return ListView(padding: const EdgeInsets.all(0), shrinkWrap: true,
//              physics: ScrollPhysics(),
                children: [
                  _header(),
                  SizedBox(height: widget.height - 115, child: listWidget),
                  _divider(),
                  _speakRow()
                ]);
          }
        }
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .progressIndicatorStyle()
            .progressIndicator(context);
      });
    });
  }

  Widget _header() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
            height: 35,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .textStyle()
                  .h4(context, _roomName()),
              const Spacer(),
              StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .buttonStyle()
                  .dialogButton(context,
                      label: 'Close',
                      onPressed: () => ChatDashboardBloc.selectOption(
                          context, widget.selectedOptionBeforeChat))
            ])),
        _divider()
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      height: 15,
      thickness: 5,
      color: Colors.red,
    );
  }

  Widget _speakField() {
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .texFormFieldStyle()
        .textField(
          context,
          readOnly: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.send,
          onSubmitted: (value) => _comment(value),
          controller: _commentController,
          keyboardType: TextInputType.text,
          hintText: 'Say something...',
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
      Container(height: 50, child: buttonAdd()),
    ]);
  }

  Widget buttonAdd() {
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .buttonStyle()
        .button(
      context,
      label: 'Ok',
      onPressed: () {
        _comment(_commentController.text);
      },
    );
  }

  void _comment(String? value) {
    if ((value != null) && (value.isNotEmpty)) {
      BlocProvider.of<ChatListBloc>(context).add(ChatListEvent.AddChatList(
          value: ChatModel(
        documentID: newRandomKey(),
        appId: widget.appId,
        roomId: widget.roomId,
        authorId: widget.memberId,
        readAccess: widget.readAccess,
        saying: value,
      )));
      _commentController.clear();
      _gotoBottom();
    }
  }

  void _gotoBottom() {
    if (SchedulerBinding.instance != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        controller1.animateTo(
          controller1.position.maxScrollExtent,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _onClick() {
    requestedNewPage = true;
    BlocProvider.of<ChatListBloc>(context).add(ChatListEvent.NewPage());
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
    return Center(
        child: StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .buttonStyle()
            .button(
      context,
      label: 'More...',
      onPressed: () {
        widget.onClickFunction!();
      },
    ));
  }
}
