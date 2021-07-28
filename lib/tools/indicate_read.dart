import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/extensions/dashboard/bloc/chat_dashboard_bloc.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_list_state.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class IndicateRead {
  static Future<void> setRead(String appId, String roomId, String memberId, ChatModel lastRead, List<String> readAccess) async {
    if (lastRead.timestamp != 'null') {
      var _chatMemberInfoRepository = chatMemberInfoRepository(
          appId: appId, roomId: roomId);
      if (_chatMemberInfoRepository != null) {
        var _chatMemberInfoDocumentId = memberId + '-' + roomId;
        var _chatMemberInfoModel = await _chatMemberInfoRepository.get(
            _chatMemberInfoDocumentId);
        if ((_chatMemberInfoModel == null) || (dateTimeFromTimestampString(_chatMemberInfoModel.timestamp!).compareTo(dateTimeFromTimestampString(lastRead.timestamp!))) < 0) {
          _chatMemberInfoModel = ChatMemberInfoModel(
            documentID: _chatMemberInfoDocumentId,
            authorId: memberId,
            roomId: roomId,
            readAccess: readAccess,
          );
          _chatMemberInfoRepository.add(_chatMemberInfoModel);
        }
      }
    }
  }
}
