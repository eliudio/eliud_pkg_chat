import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/sty'
    'le/frontend/has_progress_indicator.dart';
import 'package:eliud_core/style/frontend/has_style.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_text_form_field.dart';
import 'package:eliud_core/tools/random.dart';
import 'chat_list_bloc/chat_list_bloc.dart';
import 'chat_list_bloc/chat_list_event.dart';
import 'chat_list_bloc/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_view/split_view.dart';
import 'package:transparent_image/transparent_image.dart';

import 'all_chats_bloc/all_chats_bloc.dart';
import 'all_chats_bloc/all_chats_event.dart';
import 'all_chats_bloc/all_chats_state.dart';
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
            button(context, label: 'Member', onPressed: () {
              openFlexibleDialog(context, widget.appId + '/chat',
                  title: 'Chat with one of your followers',
                  child: MembersWidget(
                    appId: widget.appId,
                    selectedMember: (String memberId) async {
                      var room = await RoomHelper.getRoomForMember(
                          widget.appId, widget.memberId, memberId);
                      _selectRoom(context, room);
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
        final chats = state.enhancedRoomModels;
        final currentChat = state.currentRoom;
        return OrientationBuilder(builder: (context, orientation) {
          //var weight = _splitViewController!.weights[0]!;
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
                    ListView.separated(
                        separatorBuilder: (context, index) => divider(context),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final value = chats[index];
                          return roomListEntry(value);
                        })
                ]),
                if (currentChat != null)
                  ChatWidget(
                    memberId: widget.memberId,
                  )
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
    var nameList = room.otherMembersRoomInfo.map((e) => e.name).toList();
    var names = nameList.join(", ");

    var nameWidget = room.hasUnread
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
          _selectRoom(context, room.roomModel);
        },
        trailing: text(
            context, timestampRoom != null ? formatHHMM(timestampRoom) : 'now'),
        leading: SizedBox(
          height: 100,
          width: 100,
          child: staggeredPhotos,
        ),
        title: nameWidget);
  }
}

class ChatWidget extends StatefulWidget {
  final String memberId;

  const ChatWidget({
    Key? key,
    required this.memberId,
  }) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController controller1 = ScrollController();
  final List<MemberMediumModel> media = [];
  double? progressValue;

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
    return BlocBuilder<ChatListBloc, ChatListState>(builder: (context, state) {
      if (state is ChatListLoaded) {
        var room = state.room;
        List<Widget> widgets = [];
        int len = state.values.length;
        String saying;
        String? timeString;
        for (int i = 0; i < len; i++) {
          List<MemberMediumModel> itemMedia = [];
          ChatModel value = state.values[len - i - 1];
          if ((value.chatMedia != null) && (value.chatMedia!.isNotEmpty)) {
            for (var medium in value.chatMedia!) {
              if (medium.memberMedium != null) {
                itemMedia.add(medium.memberMedium!);
              }
            }
          }
          var itsMe = value.authorId == widget.memberId;
          var timestamp =
              (value.timestamp == 'null') || (value.timestamp == null)
                  ? DateTime.now()
                  : value.timestamp!;
          var timeString =
              (value.timestamp == 'null') || (value.timestamp == null)
                  ? 'Now'
                  : formatHHMM(value.timestamp!);
          var hasRead;
          if (itsMe) {
            hasRead = (timestamp != null) &&
                (state.room.otherMemberLastRead != null) &&
                (state.room.otherMemberLastRead!.compareTo(timestamp) >= 0);
          } else {
            hasRead = (timestamp != null) &&
                (state.room.timeStampThisMemberRead != null) &&
                (state.room.timeStampThisMemberRead!.compareTo(timestamp) >= 0);
          }
          var saying = value.saying ?? '.';
          widgets.add(GestureDetector(
            onTap: () => BlocProvider.of<ChatListBloc>(context)
                .add((MarkAsRead(room, value))),
            child: BubbleSpecialOne(
                text: saying,
                isSender: itsMe,
                sent: itsMe,
                seen: hasRead,
                color: Colors.white,
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
          ));

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
                  timeWidget: Text(
                    timeString,
                    style: styleSmallText(context),
                  ),
                  widget: mediaWidget),
            );
          }
        }

        List<Widget> reorderedWidgets = [];
        reorderedWidgets
            .add(_buttonNextPage(state.mightHaveMore!, room.roomModel));
        reorderedWidgets.add(divider(context));
        reorderedWidgets.addAll(widgets);
        return ListView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              header(room.roomModel),
              divider(context),
              ListView(
                  reverse: true,
                  controller: controller1,
                  shrinkWrap: true,
                  children: reorderedWidgets),
            ]);
      } else {
        return Container();
      }
    });
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

  double SPEAK_ROW_HEIGHT = 50.0;
  Widget header(RoomModel room) {
    return ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          SizedBox(
              height: SPEAK_ROW_HEIGHT,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                iconButton(
                  context,
                  icon: const Icon(
                    Icons.people,
                    size: 30.0,
                  ),
                  onPressed: () {
                    openFlexibleDialog(context,
                        AccessBloc.currentAppId(context) + '/addtochat',
                        title: 'Add one of your followers to the chat',
                        child: MembersWidget(
                          appId: room.appId!,
                          selectedMember: (String newMemberId) async {
                            List<String> newMembers = room.members!;
                            if (!newMembers.contains(newMemberId)) {
                              newMembers.add(newMemberId);
                              if (room.members!.length == 3) {
                                // was 2, so we need to create a new room with multiple members
//                                Navigator.of(context).pop();
                                var newRoom =
                                    await RoomHelper.getRoomForMembers(
                                        room.appId!,
                                        widget.memberId,
                                        newMembers);
                                _selectRoom(context, newRoom);
                              } else {
                                BlocProvider.of<AllChatsBloc>(context).add(
                                    UpdateAllChats(
                                        value: room.copyWith(
                                            members: newMembers)));
                              }
                            }
                          },
                          currentMemberId: widget.memberId,
                        ),
                        buttons: [
                          dialogButton(context,
                              label: 'Close',
                              onPressed: () => Navigator.of(context).pop()),
                        ]);
                  },
                ),
                Flexible(
                  child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: textField(
                        context,
                        readOnly: false,
                        textAlign: TextAlign.left,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (value) => _submit(room, value),
                        controller: _commentController,
                        keyboardType: TextInputType.text,
                        hintText: 'Say something...',
                      )),
                ),
                const SizedBox(width: 8),
                MediaButtons.mediaButtons(
                    context, room.appId!, widget.memberId, room.members,
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
                    videoFeedbackProgress: _uploading),
                const SizedBox(width: 8),
                button(
                  context,
                  label: 'Ok',
                  onPressed: () {
                    _submit(room, _commentController.text);
                  },
                ),
              ])),
          _mediaRow(context),
          divider(context),
        ]);
  }

  void _submit(RoomModel room, String? value) {
    if ((value != null) && (value.isNotEmpty) || media.isNotEmpty) {
      progressValue = null;
      var mappedMedia = media
          .map((medium) => ChatMediumModel(
                documentID: medium.documentID,
                memberMedium: medium,
              ))
          .toList();

      BlocProvider.of<ChatListBloc>(context).add(AddChatList(
          value: ChatModel(
        documentID: newRandomKey(),
        appId: room.appId!,
        roomId: room.documentID,
        authorId: widget.memberId,
        readAccess: room.members,
        chatMedia: mappedMedia,
        saying: value,
      )));
      _commentController.clear();
      media.clear();
    }
  }

  void _uploading(double? progress) {
    setState(() {
      progressValue = progress;
    });
  }

  Widget _buttonNextPage(bool mightHaveMore, RoomModel room) {
    if (mightHaveMore) {
      return MyButton(
        onClickFunction: () =>
            BlocProvider.of<ChatListBloc>(context).add(NewChatPage(room)),
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

  const MyButton({Key? key, this.onClickFunction}) : super(key: key);

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

void _selectRoom(BuildContext context, RoomModel room) {
  BlocProvider.of<AllChatsBloc>(context).add(SelectChat(selected: room));
}
