import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_style.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_text_form_field.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/extensions/widgets/bloc/all_chats_state.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart' as ChatListEvent;
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/tools/indicate_read.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_view/split_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bloc/all_chats_bloc.dart';
import 'bloc/all_chats_event.dart';
import 'members_widget.dart';

class AllChatsWidget extends StatefulWidget {
  final String memberId;
  final String appId;

  const AllChatsWidget({
    Key? key,
    required this.appId,
    required this.memberId,
  }) : super(key: key);

  @override
  AllChatsWidgetState createState() => AllChatsWidgetState();
}

class AllChatsWidgetState extends State<AllChatsWidget> {
  RoomModel? theRoom;
  SplitViewController? _splitViewController;

  @override
  void initState() {
    _splitViewController = SplitViewController(weights: [
      0.3,
      0.7
    ], limits: [
      WeightLimit(min: 0.2, max: 0.8),
      WeightLimit(min: 0.2, max: 0.8)
    ]);
    super.initState();
  }

  double HEADER_HEIGHT = 60;
  Widget header() {
    return SizedBox(
        height: HEADER_HEIGHT,
        child: Column(children: [
          Row(children: [
            const Spacer(),
            button(context,
                label: 'Close', onPressed: () => Navigator.of(context).pop()),
            const Spacer(),
            button(context, label: 'Chat', onPressed: () {
              openFlexibleDialog(context, widget.appId + '/chat',
                  title: 'Chat with one of your followers',
                  child: MembersWidget(
                    appId: widget.appId,
                    selectedMember: (String memberId) async {
                      var room = await RoomHelper.getRoomForMember(
                          widget.appId, widget.memberId, memberId);
                      BlocProvider.of<AllChatsBloc>(context)
                          .add(SelectChat(selected: room));
                    },
                    currentMemberId: widget.memberId,
                  ),
                  buttons: [
                    dialogButton(context,
                        label: 'Close',
                        onPressed: () => Navigator.of(context).pop()),
                  ]);
            }),
            const Spacer(),
          ]),
          divider(context),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllChatsBloc, AllChatsState>(builder: (context, state) {
      if (state is AllChatsLoaded) {
        final chats = state.values;
        final currentChat = state.currentRoom;
        return OrientationBuilder(builder: (context, orientation) {
          var weight = _splitViewController!.weights[0]!;
          var screenHeight = MediaQuery.of(context).size.height;
          return SplitView(
              gripColor: Colors.red,
              controller: _splitViewController,
              onWeightChanged: (newWeight) {
                setState(() {});
              },
              children: [
                ListView(children: [
                  header(),
                  if (chats != null)
                    SizedBox(
                        height: orientation == Orientation.landscape
                            ? screenHeight - HEADER_HEIGHT
                            : (screenHeight * weight) - HEADER_HEIGHT,
                        child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                divider(context),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              final value = chats[index];
                              return roomListEntry(value);
                            }))
                ]),
                if (currentChat != null)
                  room(
                      currentChat,
                      orientation == Orientation.landscape
                          ? screenHeight
                          : (screenHeight * (1 - weight)))
                else
                  Container()
              ],
              viewMode: orientation == Orientation.landscape
                  ? SplitViewMode.Horizontal
                  : SplitViewMode.Vertical);
        });
      } else {
        return progressIndicator(context);
      }
    });
  }

  Widget roomListEntry(EnhancedRoomModel room) {
    var timestampRoom = (room.roomModel.timestamp != null)
        ? room.roomModel.timestamp!
        : DateTime.now();
    var memberLastRead = room.timeStampThisMemberRead;
    var hasUnread = (memberLastRead == null) ||
        (timestampRoom.compareTo(memberLastRead) > 0);

    var nameList = room.otherMembersRoomInfo.map((e) => e.name).toList();
    var names = nameList.join(", ");

    var nameWidget = hasUnread
        ? highLight1(
            context,
            names,
          )
        : text(
            context,
            names,
          );
    Widget staggeredPhotos = StaggeredGridView.extentBuilder(
      scrollDirection: Axis.horizontal,
      primary: true,
      maxCrossAxisExtent: 150,
      itemCount: room.otherMembersRoomInfo.length,
      itemBuilder: (context, i) {
        var avatar = room.otherMembersRoomInfo[i].avatar;
        if (avatar != null) {
          return FadeInImage.memoryNetwork(
            height: 50,
            placeholder: kTransparentImage,
            image: avatar,
          );
        } else {
          return const Center(child: Text('No photo'));
        }
      },
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      staggeredTileBuilder: (_) => const StaggeredTile.fit(100),
    );

    return ListTile(
        onTap: () async {
          BlocProvider.of<AllChatsBloc>(context)
              .add(SelectChat(selected: room.roomModel));
        },
        trailing: text(
            context, timestampRoom != null ? formatHHMM(timestampRoom) : 'now'),
        leading: Container(
          height: 100,
          width: 100,
          child: staggeredPhotos,
        ),
        title: nameWidget);
  }

  Widget room(RoomModel room, double screenHeight) {
    var eliudQueryChatList = EliudQuery().withCondition(
        EliudQueryCondition('readAccess', arrayContains: widget.memberId));
    return BlocProvider<ChatListBloc>(
        create: (context) => ChatListBloc(
              paged: true,
              orderBy: 'timestamp',
              descending: true,
              detailed: true,
              eliudQuery: eliudQueryChatList,
              chatLimit: 100,
              chatRepository:
                  chatRepository(appId: room.appId, roomId: room.documentID!)!,
            )..add(ChatListEvent.LoadChatList()),
        child: ChatWidget(
          room: room,
          memberId: widget.memberId,
          screenHeight: screenHeight,
//            height: widget.height,
        ));
  }
}

class ChatWidget extends StatefulWidget {
  final RoomModel room;
  final String memberId;
  final double screenHeight;
//  final double height;

  const ChatWidget({
    Key? key,
    required this.room,
    required this.memberId,
    required this.screenHeight,
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
    var otherMemberLastRead;

    return BlocBuilder<ChatListBloc, ChatListState>(builder: (context, state) {
      if (state is ChatListLoaded) {
        List<Widget> widgets = [];
        int len = state.values!.length;
        DateTime? oldDate;
        String saying;
        var itsMe = true;
        String? timeString;
        ChatModel? lastRead; // what's the last item I've just read?
        for (int i = 0; i < len; i++) {
          DateTime? newDate;
          var hasRead = false; // did the other member read the message yet?
          List<MemberMediumModel> itemMedia = [];
          if (state.values![len - i - 1] != null) {
            ChatModel value = state.values![len - i - 1]!;
            if ((value.chatMedia != null) && (value.chatMedia!.isNotEmpty)) {
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
                newDate = timestamp;
                DateTime newDateTime = timestamp;
                timeString = formatHHMM(newDateTime);
                if ((itsMe) &&
                    ((otherMemberLastRead != null) &&
                        (otherMemberLastRead.compareTo(newDateTime) >= 0))) {
                  hasRead = true;
                }
                lastRead = value;
              }
            }
          } else {
            saying = 'Eek2 - This is an error';
          }
          if ((oldDate == null) ||
              newDate != null && !isSameDate(newDate, oldDate)) {
            widgets.add(Center(
                child: DateChip(
              date: newDate!,
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
              var medium = itemMedia[index];
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
                          style: styleSmallText(context),
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
        reorderedWidgets.add(divider(context));
        reorderedWidgets.addAll(widgets);
        if (!dontGoToBottom) {
          _gotoBottom();
        }
        dontGoToBottom = false;
        return ListView(padding: const EdgeInsets.all(0), shrinkWrap: true,
//              physics: ScrollPhysics(),
            children: [
              SizedBox(
                  height: widget.screenHeight - footerHeight(),
                  child: ListView(
                      controller: controller1,
                      shrinkWrap: true,
                      children: reorderedWidgets)),
              footer(),
            ]);
      } else {
        return progressIndicator(context);
      }
    });
  }

  Widget _speakField() {
    return textField(
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

  double footerHeight() {
    if ((media.isNotEmpty) || (progressValue != null)) {
      return MEDIA_ROW_HEIGHT + SPEAK_ROW_HEIGHT;
    } else {
      return SPEAK_ROW_HEIGHT;
    }
  }

  double MEDIA_ROW_HEIGHT = 100;
  Widget _mediaRow(BuildContext context) {
    if ((media.isNotEmpty) || (progressValue != null)) {
      return MediaHelper.staggeredMemberMediumModel(context, media,
          height: MEDIA_ROW_HEIGHT,
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

  Widget footer() {
    return ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          divider(context),
          _speakRow(),
          _mediaRow(context),
        ]);
  }

  double SPEAK_ROW_HEIGHT = 100;
  Widget _speakRow() {
    return SizedBox(
        height: 50,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 50, child: buttonAddMember()),
          Flexible(
            child: Container(
                alignment: Alignment.center, height: 30, child: _speakField()),
          ),
          const SizedBox(width: 8),
          _mediaButtons(context),
          const SizedBox(width: 8),
          SizedBox(
              height: 50,
              child: button(
                context,
                label: 'Ok',
                onPressed: () {
                  _submit(_commentController.text);
                },
              )),
        ]));
  }

  Widget buttonAddMember() {
    return iconButton(
      context,
      icon: const Icon(
        Icons.people,
        size: 30.0,
      ),
      onPressed: () {
        openFlexibleDialog(
            context, AccessBloc.currentAppId(context) + '/addtochat',
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
                    BlocProvider.of<AllChatsBloc>(context)
                        .add(SelectChat(selected: newRoom));
                  } else {
                    BlocProvider.of<AllChatsBloc>(context).add(UpdateAllChats(
                        value: widget.room.copyWith(members: newMembers)));
                  }
                }
              },
              currentMemberId: widget.memberId,
            ),
            buttons: [
              dialogButton(context,
                  label: 'Close', onPressed: () => Navigator.of(context).pop()),
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
/*
    if (SchedulerBinding.instance != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        if (controller1.hasClients) {
          controller1.jumpTo(controller1.position.maxScrollExtent);
        }
      });
    }
*/
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
      return Center(
          child: h5(
        context,
        "That's all folks",
      ));
    }
  }
}

class MyButton extends StatefulWidget {
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
        child: button(
      context,
      label: 'More...',
      onPressed: () {
        widget.onClickFunction!();
      },
    ));
  }
}
