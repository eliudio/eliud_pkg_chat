import 'package:eliud_core/model/app_model.dart';
import 'package:flutter/cupertino.dart';
import '../extensions/widgets/chat_bloc/chat_bloc.dart';
import '../extensions/widgets/chat_bloc/chat_event.dart';
import '../extensions/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHelper {

  Widget openForMember(AppModel app, String thisMemberId, String otherMemberId) {
    return BlocProvider<ChatBloc>(create: (context) => ChatBloc(
      thisMemberId: thisMemberId, appId: app.documentID,
    )..add(OpenChatWithAMemberEvent(otherMemberId)),
        child: ChatWidget(app: app, memberId: thisMemberId));
  }

  Widget openForMembers(AppModel app, String thisMemberId, List<String> otherMemberIds) {
    return BlocProvider<ChatBloc>(create: (context) => ChatBloc(
      thisMemberId: thisMemberId, appId: app.documentID,
    )..add(OpenChatWithMembersEvent(otherMemberIds)),
        child: ChatWidget(app: app, memberId: thisMemberId));
  }
}