import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/widgets/members_widget.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart' as ChatListEvent;
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart'
    as ChatMemberInfoListEvent;
import 'package:eliud_pkg_chat/model/chat_member_info_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/indicate_read.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  final String memberId;
  final double height;
  final String appId;

  ChatPage({
    Key? key,
    required this.roomId,
    required this.appId,
    required this.memberId,
    required this.height,
  }) : super(key: key) {}

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var eliudQueryRoomList = EliudQuery().withCondition(
        EliudQueryCondition('__name__', isEqualTo: widget.roomId));

    return BlocProvider<RoomListBloc>(
        create: (context) => RoomListBloc(
            roomRepository: roomRepository(appId: widget.appId)!,
            eliudQuery: eliudQueryRoomList)
          ..add(LoadRoomList()),
        child: child());
  }

  Widget child() {
    return BlocBuilder<RoomListBloc, RoomListState>(builder: (context, state) {
      if ((state is RoomListLoaded) &&
          (state.values != null) &&
          (state.values!.isNotEmpty)) {
        return room(state.values![0]!);
      } else {
        return StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .progressIndicatorStyle()
            .progressIndicator(context);
      }
    });
  }

  Widget room(RoomModel room) {
    var eliudQueryChatList = EliudQuery().withCondition(
        EliudQueryCondition('readAccess', arrayContains: widget.memberId));

    var eliudQueryChatMemberInfoList = EliudQuery()
//        .withCondition(EliudQueryCondition('appId', isEqualTo: widget.appId))
//        .withCondition(EliudQueryCondition('roomId', isEqualTo: widget.roomId))
        .withCondition(
            EliudQueryCondition('readAccess', arrayContainsAny: [widget.memberId]));

    return MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<ChatListBloc>(
              create: (context) => ChatListBloc(
                    paged: true,
                    orderBy: 'timestamp',
                    descending: true,
                    detailed: true,
                    eliudQuery: eliudQueryChatList,
                    chatLimit: 100,
                    chatRepository: chatRepository(
                        appId: room.appId, roomId: room.documentID!)!,
                  )..add(ChatListEvent.LoadChatList())),
          BlocProvider<ChatMemberInfoListBloc>(
              create: (context) => ChatMemberInfoListBloc(
                    eliudQuery: eliudQueryChatMemberInfoList,
                    chatMemberInfoRepository: chatMemberInfoRepository(
                        appId: room.appId, roomId: room.documentID!)!,
                  )..add(ChatMemberInfoListEvent.LoadChatMemberInfoList())),
        ],
        child: ChatWidget(
          room: room,
          memberId: widget.memberId,
          height: widget.height,
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
  final RoomModel room;
  final String memberId;
  final double height;

  const ChatWidget({
    Key? key,
    required this.room,
    required this.memberId,
    required this.height,
  }) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController controller1 = ScrollController();
  bool dontGoToBottom = false;
  final List<MemberMediumModel> media = [];
  double? progressValue = null;

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
          for (var value in chatMemberInfoState.values!) {
            if (value!.authorId != widget.memberId) {
              var otherMemberLastReadThisOne =
                  dateTimeFromTimestampString(value.timestamp!);
              if ((otherMemberLastRead == null) ||
                  (otherMemberLastReadThisOne.compareTo(otherMemberLastRead!) <
                      0)) {
                otherMemberLastRead = otherMemberLastReadThisOne;
              }
            }
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
              List<MemberMediumModel> itemMedia = [];
              if (state.values![len - i - 1] != null) {
                ChatModel value = state.values![len - i - 1]!;
                if ((value.chatMedia != null) &&
                    (value.chatMedia!.isNotEmpty)) {
                  for (var medium in value.chatMedia!) {
                    if (medium.memberMedium != null) {
                      itemMedia.add(medium.memberMedium!);
                    }
                  }
                }
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
                    DateTime newDateTime =
                        dateTimeFromTimestampString(timestamp);
                    timeString = formatHHMM(newDateTime);
                    if ((itsMe) &&
                        ((otherMemberLastRead != null) &&
                            (otherMemberLastRead!.compareTo(newDateTime) >=
                                0))) {
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
              if (saying.isNotEmpty) {
                widgets.add(
                  BubbleSpecialOne(
                      text: saying,
                      isSender: itsMe,
                      sent: itsMe,
                      seen: hasRead,
                      color: Colors.white,
                      //const Color(0xFF1B97F3),
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
                          .styleSmallText(context)!),
                );
              }

              if (itemMedia.isNotEmpty) {
                var mediaWidget = MediaHelper.staggeredMemberMediumModel(
                    context, itemMedia,
                    reverse: itsMe,
                    shrinkWrap: true,
                    height: 150,
                    progressExtra: null, viewAction: (index) {
                  var medium = itemMedia![index];
                  if (medium.mediumType == MediumType.Photo) {
                    var photos = itemMedia;
                    AbstractMediumPlatform.platform!
                        .showPhotos(context, photos, index);
                  } else {
                    AbstractMediumPlatform.platform!.showVideo(context, medium);
                  }
                });
                widgets.add(
                  FlexibleBubbleSpecialOne(
                      isSender: itsMe,
                      sent: itsMe,
                      seen: hasRead,
                      color: Colors.white, //const Color(0xFF1B97F3),
                      timeWidget: timeString != null
                          ? Text(
                              timeString,
                              style: StyleRegistry.registry()
                                  .styleWithContext(context)
                                  .frontEndStyle()
                                  .textStyleStyle()
                                  .styleSmallText(context),
                            )
                          : null,
                      widget: mediaWidget),
                );
              }
            }

            if (lastRead != null) {
              IndicateRead.setRead(widget.room.appId!, widget.room.documentID!,
                  widget.memberId, lastRead, widget.room.members!);
            }
            List<Widget> reorderedWidgets = [];
            reorderedWidgets.add(_buttonNextPage(state.mightHaveMore!));
            reorderedWidgets.addAll(widgets);
            var listWidget = ListView(
                controller: controller1,
                shrinkWrap: true,
                children: reorderedWidgets);
            if (!dontGoToBottom) {
              _gotoBottom();
            }
            dontGoToBottom = false;
            return ListView(padding: const EdgeInsets.all(0), shrinkWrap: true,
//              physics: ScrollPhysics(),
                children: [
                  SizedBox(
                      height: widget.height -
                          (((media.isNotEmpty) || (progressValue != null))
                              ? 216
                              : 116),
                      child: listWidget),
                  _divider(),
                  _speakRow(),
                  _mediaRow(context),
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
          onSubmitted: (value) => _submit(value),
          controller: _commentController,
          keyboardType: TextInputType.text,
          hintText: 'Say something...',
        );
  }

  Widget _mediaRow(BuildContext context) {
    if ((media.isNotEmpty) || (progressValue != null)) {
      return MediaHelper.staggeredMemberMediumModel(context, media,
          height: 100,
          progressLabel: 'Uploading...',
          progressExtra: progressValue, deleteAction: (index) {
        setState(() {
          media.removeAt(index);
        });
      }, viewAction: (index) {
        var medium = media[index];
        if (medium.mediumType == MediumType.Photo) {
          var photos = media;
          AbstractMediumPlatform.platform!.showPhotos(context, photos, index);
        } else {
          AbstractMediumPlatform.platform!.showVideo(context, medium);
        }
      });
    } else {
      return Container(height: 1);
    }
  }

  Widget _speakRow() {
    return Row(children: [
      Container(height: 50, child: buttonAddMember()),
      Flexible(
        child: Container(
            alignment: Alignment.center, height: 30, child: _speakField()),
      ),
      Container(width: 8),
      _mediaButtons(context),
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
        _submit(_commentController.text);
      },
    );
  }

  Widget buttonAddMember() {
    return StyleRegistry.registry()
        .styleWithContext(context)
        .frontEndStyle()
        .buttonStyle()
        .iconButton(
      context,
      icon: const Icon(
        Icons.people,
        size: 30.0,
      ),
      onPressed: () {
        StyleRegistry.registry()
            .styleWithContext(context)
            .frontEndStyle()
            .dialogStyle()
            .openFlexibleDialog(context,
                title: 'Add one of your followers to the chat',
                child: MembersWidget(
                  appId: widget.room.appId!,
                  selectedMember: (String newMemberId) async {
                    List<String> newMembers = widget.room.members!;
                    if (!newMembers.contains(newMemberId)) {
                      newMembers.add(newMemberId);
                      if (widget.room.members!.length == 3) {
                        // was 2, so we need to create a new room with multiple members
                        Navigator.of(context).pop();
                        var newRoom = await RoomHelper.getRoomForMembers(
                            widget.room.appId!, widget.memberId, newMembers);
                        ChatDashboardBloc.openRoom(
                            context, newRoom, widget.memberId);
                      } else {
                        BlocProvider.of<RoomListBloc>(context).add(
                            UpdateRoomList(
                                value:
                                    widget.room.copyWith(members: newMembers)));
                      }
                    }
                  },
                  currentMemberId: widget.memberId,
                ),
                buttons: [
              StyleRegistry.registry()
                  .styleWithContext(context)
                  .frontEndStyle()
                  .buttonStyle()
                  .dialogButton(context,
                      label: 'Close',
                      onPressed: () => Navigator.of(context).pop()),
            ]);
      },
    );
  }

  void _submit(String? value) {
    if ((value != null) && (value.isNotEmpty) || media.isNotEmpty) {
      progressValue = null;
      var mappedMedia = media
          .map((medium) => ChatMediumModel(
                documentID: medium.documentID,
                memberMedium: medium,
              ))
          .toList();

      BlocProvider.of<ChatListBloc>(context).add(ChatListEvent.AddChatList(
          value: ChatModel(
        documentID: newRandomKey(),
        appId: widget.room.appId!,
        roomId: widget.room.documentID,
        authorId: widget.memberId,
        readAccess: widget.room.members,
        chatMedia: mappedMedia,
        saying: value,
      )));
      _commentController.clear();
      _gotoBottom();
      media.clear();
    }
  }

  void _gotoBottom() {
    if (SchedulerBinding.instance != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        controller1.animateTo(
          controller1.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _uploading(double? progress) {
    setState(() {
      progressValue = progress;
    });
  }

  PopupMenuButton _mediaButtons(BuildContext context) {
    return MediaButtons.mediaButtons(
        context, widget.room.appId!, widget.memberId, widget.room.members,
        tooltip: 'Add video or photo',
        photoFeedbackFunction: (photo) {
          setState(() {
            progressValue = null;
            if (photo != null) {
              media.add(photo);
            }
          });
        },
        photoFeedbackProgress: _uploading,
        videoFeedbackFunction: (video) {
          setState(() {
            progressValue = null;
            if (video != null) {
              media.add(video);
            }
          });
        },
        videoFeedbackProgress: _uploading);
  }

  void _onClick() {
    dontGoToBottom = true;
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
              return const Divider(
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
