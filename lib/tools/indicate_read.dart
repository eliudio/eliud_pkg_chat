import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/tools/room_helper.dart';

class IndicateRead {
  static Future<void> setRead(String appId, String roomId, String memberId, ChatModel lastRead, List<String> readAccess) async {
    if (lastRead.timestamp != 'null') {
      var _chatMemberInfoRepository = chatMemberInfoRepository(
          appId: appId, roomId: roomId);
      if (_chatMemberInfoRepository != null) {
        var _chatMemberInfoDocumentId = RoomHelper.getChatMemberInfoId(memberId, roomId);
        var _chatMemberInfoModel = await _chatMemberInfoRepository.get(
            _chatMemberInfoDocumentId);
        try {
          if ((_chatMemberInfoModel == null) ||
              (_chatMemberInfoModel.timestamp!
                  .compareTo(lastRead.timestamp!)) < 0) {
            _chatMemberInfoModel = ChatMemberInfoModel(
              documentID: _chatMemberInfoDocumentId,
              authorId: memberId,
              roomId: roomId,
              readAccess: readAccess,
            );
            await _chatMemberInfoRepository.add(_chatMemberInfoModel);
          }
        } catch (_) {
          // issue with timestamp: ignore
        }
      }
    }
  }
}
