import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_medium_model.dart';
import 'package:eliud_core/style/frontend/has_button.dart';
import 'package:eliud_core/style/frontend/has_dialog.dart';
import 'package:eliud_core/style/frontend/has_divider.dart';
import 'package:eliud_core/style/frontend/has_style.dart';
import 'package:eliud_core/style/frontend/has_text.dart';
import 'package:eliud_core/style/frontend/has_text_form_field.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:tuple/tuple.dart';
import 'all_chats_widget.dart';
import 'chat_bloc/chat_bloc.dart';
import 'chat_bloc/chat_event.dart';
import 'chat_bloc/chat_state.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_medium/platform/medium_platform.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_chats_bloc/all_chats_bloc.dart';
import 'all_chats_bloc/all_chats_event.dart';
import 'members_widget.dart';

class ChatWidget extends StatefulWidget {
  final AppModel app;
  final String memberId;

  const ChatWidget({
    Key? key,
    required this.app,
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
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if (state is ChatLoaded) {
        var room = state.room;
        List<Widget> widgets = [];
        int len = state.values.length;
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
          var from;
          if (itsMe) {
            hasRead = (timestamp != null) &&
                (state.room.otherMemberLastRead != null) &&
                (state.room.otherMemberLastRead!.compareTo(timestamp) >= 0);
          } else {
            if (room.otherMembersRoomInfo.length > 1) {
              for (var other in room.otherMembersRoomInfo) {
                if (other.memberId == value.authorId) {
                  from = other.name;
                }
              }
            }

            hasRead = (timestamp != null) &&
                (state.room.timeStampThisMemberRead != null) &&
                (state.room.timeStampThisMemberRead!.compareTo(timestamp) >= 0);
          }

          var saying = value.saying ?? '.';
          widgets.add(GestureDetector(
            onTap: () => BlocProvider.of<ChatBloc>(context)
                .add((MarkAsRead(room, value))),
            child: BubbleSpecialOne(
                text: from == null ? saying : from + "\n" + saying,
                isSender: itsMe,
                sent: itsMe,
                seen: hasRead,
                color: Colors.white,
                time: timeString,
                textStyle: StyleRegistry.registry()
                    .styleWithApp(widget.app)
                    .frontEndStyle()
                    .textStyleStyle()
                    .styleText(widget.app, context)!,
                timeTextStyle: StyleRegistry.registry()
                    .styleWithApp(widget.app)
                    .frontEndStyle()
                    .textStyleStyle()
                    .styleSmallText(widget.app, context)!),
          ));

          if (itemMedia.isNotEmpty) {
            var mediaWidget = MediaHelper.staggeredMemberMediumModel(
                widget.app, context, itemMedia,
                reverse: itsMe,
                shrinkWrap: true,
                height: 150,
                progressExtra: null, viewAction: (index) {
              var medium = itemMedia[index];
              if (medium.mediumType == MediumType.Photo) {
                var photos = itemMedia;
                AbstractMediumPlatform.platform!
                    .showPhotos(context, widget.app, photos, index);
              } else {
                AbstractMediumPlatform.platform!
                    .showVideo(context, widget.app, medium);
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
                    style: styleSmallText(widget.app, context),
                  ),
                  widget: mediaWidget),
            );
          }
        }

        List<Widget> reorderedWidgets = [];
        reorderedWidgets
            .add(_buttonNextPage(state.mightHaveMore!, room.roomModel));
        reorderedWidgets.add(divider(widget.app, context));
        reorderedWidgets.addAll(widgets);
        return ListView(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              header(room.roomModel),
              divider(widget.app, context),
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
      return MediaHelper.staggeredMemberMediumModel(widget.app, context, media,
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
          AbstractMediumPlatform.platform!
              .showPhotos(context, widget.app, photos, index);
        } else {
          AbstractMediumPlatform.platform!
              .showVideo(context, widget.app, medium);
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
                  widget.app,
                  context,
                  icon: const Icon(
                    Icons.people,
                    size: 30.0,
                  ),
                  onPressed: () {
                    openFlexibleDialog(widget.app, context,
                        widget.app.documentID! + '/addtochat',
                        title: 'Add one of your followers to the chat',
                        child: MembersWidget(
                          app: widget.app,
                          selectedMember: (String newMemberId) async {
                            List<String> newMembers = room.members!;
                            if (!newMembers.contains(newMemberId)) {
                              newMembers.add(newMemberId);
                              if (room.members!.length == 3) {
                                // was 2, so we need to create a new room with multiple members
//                                Navigator.of(context).pop();
                                var newRoom =
                                    await RoomHelper.getRoomForMembers(
                                        widget.app,
                                        widget.memberId,
                                        newMembers);
                                selectRoom(context, newRoom);
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
                          dialogButton(widget.app, context,
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
                        widget.app,
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
                MediaButtons.mediaButtons(context, widget.app, widget.memberId, () => Tuple2(
                    MemberMediumAccessibleByGroup.SpecificMembers,
                    room.members,),
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
                  widget.app,
                  context,
                  label: 'Ok',
                  onPressed: () {
                    _submit(room, _commentController.text);
                  },
                ),
              ])),
          _mediaRow(context),
          divider(widget.app, context),
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

      BlocProvider.of<ChatBloc>(context).add(AddChat(
          value: ChatModel(
        documentID: newRandomKey(),
        appId: room.appId!,
        roomId: room.documentID,
        authorId: widget.memberId,
        accessibleByGroup: ChatAccessibleByGroup.SpecificMembers,
        accessibleByMembers: room.members,
        chatMedia: mappedMedia,
        saying: value,
        readAccess: [widget.memberId],  // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
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
        app: widget.app,
        onClickFunction: () =>
            BlocProvider.of<ChatBloc>(context).add(NewChatPage(room)),
      );
    } else {
      return Center(
          child: h5(
        widget.app,
        context,
        "That's all folks",
      ));
    }
  }
}

class MyButton extends StatefulWidget {
  final AppModel app;
  final VoidCallback? onClickFunction;

  const MyButton({Key? key, required this.app, this.onClickFunction})
      : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: button(
      widget.app,
      context,
      label: 'More...',
      onPressed: () {
        widget.onClickFunction!();
      },
    ));
  }
}
