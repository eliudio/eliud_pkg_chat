import 'package:eliud_core_helpers/firestore/firestore_tools.dart';
import 'package:eliud_core_main/apis/apis.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/member_medium_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_button.dart';
import 'package:eliud_core_main/apis/style/frontend/has_dialog.dart';
import 'package:eliud_core_main/apis/style/frontend/has_divider.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text_bubble.dart';
import 'package:eliud_core_main/apis/style/frontend/has_text_form_field.dart';
import 'package:eliud_core_helpers/etc/random.dart';
import 'package:eliud_pkg_chat_model/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat_model/model/chat_medium_model.dart';
import 'package:eliud_pkg_chat_model/model/chat_model.dart';
import 'package:eliud_pkg_chat_model/model/room_model.dart';
import 'package:tuple/tuple.dart';
import 'all_chats_widget.dart';
import 'chat_bloc/chat_bloc.dart';
import 'chat_bloc/chat_event.dart';
import 'chat_bloc/chat_state.dart';
import 'package:eliud_pkg_medium/tools/media_buttons.dart';
import 'package:eliud_pkg_medium/tools/media_helper.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_chats_bloc/all_chats_bloc.dart';
import 'all_chats_bloc/all_chats_event.dart';
import 'members_widget.dart';

class ChatWidget extends StatefulWidget {
  final AppModel app;
  final String memberId;
  final bool canAddMember;
  final MembersType? membersType;
  final List<String> blockedMembers;

  const ChatWidget({
    super.key,
    required this.app,
    required this.memberId,
    required this.canAddMember,
    required this.membersType,
    required this.blockedMembers,
  });

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
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
        //String? timeString;
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
          /*DateTime timestamp =
              (value.timestamp == 'null') || (value.timestamp == null)
                  ? DateTime.now()
                  : value.timestamp!;
          */
          var timeString =
              (value.timestamp == null) ? 'Now' : formatHHMM(value.timestamp!);
          bool hasRead;
          String? from;
          if (itsMe) {
            hasRead = (state.room.otherMemberLastRead != null);
          } else {
//            if (room.otherMembersRoomInfo.length > 1) {
            for (var other in room.otherMembersRoomInfo) {
              if (other.memberId == value.authorId) {
                from = other.name;
              }
//              }
            }

            hasRead = (state.room.timeStampThisMemberRead != null);
          }

          var saying = value.saying ?? '.';
          Widget? mediaWidget;
          Widget? button;
          if (!itsMe) {
            button = dialogButton(widget.app, context,
                label: 'Block member',
                tooltip:
                    "Block this member to stop seeing all of it's past and future posts, comments, messages, or anything else",
                onPressed: () {
              //_blockMemberWithPostModel(postModel);
              openAckNackDialog(
                  widget.app, context, '${widget.app.documentID}/_blockmember1',
                  title: 'Block member?',
                  message: 'You are sure you want to block this member?',
                  onSelection: (choice) async {
                if (choice == 0) {
                  BlocProvider.of<AllChatsBloc>(context)
                      .add(BlockMember(memberId: value.authorId));
                }
              });
            });
          }

          if (itemMedia.isNotEmpty) {
            mediaWidget = MediaHelper.staggeredMemberMediumModel(
                widget.app, context, itemMedia,
                reverse: itsMe,
                shrinkWrap: true,
                height: 150,
                progressExtra: null, viewAction: (index) {
              var medium = itemMedia[index];
              if (medium.mediumType == MediumType.photo) {
                var photos = itemMedia;
                Apis.apis()
                    .getMediumApi()
                    .showPhotos(context, widget.app, photos, index);
              } else {
                Apis.apis()
                    .getMediumApi()
                    .showVideo(context, widget.app, medium);
              }
            });
          }

          widgets.add(GestureDetector(
            onTap: () => BlocProvider.of<ChatBloc>(context)
                .add((MarkAsRead(room, value))),
            child: textBubble(
              widget.app,
              context,
              widget: mediaWidget,
              button: button,
              text: from == null ? saying : "$from\n  $saying",
              isSender: itsMe,
              sent: itsMe,
              seen: hasRead,
              time: timeString,
            ),
          ));
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

  double mediaRowHeight = 100;
  Widget _mediaRow(BuildContext context) {
    if ((media.isNotEmpty) || (progressValue != null)) {
      return MediaHelper.staggeredMemberMediumModel(widget.app, context, media,
          height: mediaRowHeight,
          progressLabel: 'Uploading...',
          progressExtra: progressValue, deleteAction: (index) {
        setState(() {
          media.removeAt(index);
        });
      }, viewAction: (index) {
        var medium = media[index];
        if (medium.mediumType == MediumType.photo) {
          var photos = media;
          Apis.apis()
              .getMediumApi()
              .showPhotos(context, widget.app, photos, index);
        } else {
          Apis.apis().getMediumApi().showVideo(context, widget.app, medium);
        }
      });
    } else {
      return Container(height: 1);
    }
  }

  double speakRowHeight = 50.0;
  Widget header(RoomModel room) {
    return ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          SizedBox(
              height: speakRowHeight,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                if (!widget.canAddMember) Container(width: 20),
                if (widget.canAddMember)
                  iconButton(
                    widget.app,
                    context,
                    icon: const Icon(
                      Icons.people,
                      size: 30.0,
                    ),
                    onPressed: () {
                      openFlexibleDialog(widget.app, context,
                          '${widget.app.documentID}/addtochat',
                          title: 'Add one of your followers to the chat',
                          child: MembersWidget(
                            blockedMembers: widget.blockedMembers,
                            membersType: widget.membersType,
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
                                          widget.app.documentID,
                                          widget.memberId,
                                          [widget.memberId, ...newMembers]);
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
                MediaButtons.mediaButtons(
                    context,
                    widget.app,
                    () => Tuple2(
                          MemberMediumAccessibleByGroup.specificMembers,
                          room.members,
                        ),
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
        appId: room.appId,
        roomId: room.documentID,
        authorId: widget.memberId,
        accessibleByGroup: ChatAccessibleByGroup.specificMembers,
        accessibleByMembers: room.members,
        chatMedia: mappedMedia,
        saying: value,
        readAccess: [
          widget.memberId
        ], // default readAccess to the owner. The function will expand this based on accessibleByGroup/Members
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

  const MyButton({super.key, required this.app, this.onClickFunction});

  @override
  State<MyButton> createState() => _MyButtonState();
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
