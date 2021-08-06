/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/abstract_repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/chat_repository.dart';
import '../model/chat_dashboard_repository.dart';
import '../model/chat_medium_repository.dart';
import '../model/chat_member_info_repository.dart';
import '../model/member_has_chat_repository.dart';
import '../model/room_repository.dart';
import 'package:eliud_core/core/access/bloc/user_repository.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/package/package.dart';

ChatRepository? chatRepository({ String? appId,  String? roomId}) => AbstractRepositorySingleton.singleton.chatRepository(appId, roomId);
ChatDashboardRepository? chatDashboardRepository({ String? appId }) => AbstractRepositorySingleton.singleton.chatDashboardRepository(appId);
ChatMemberInfoRepository? chatMemberInfoRepository({ String? appId,  String? roomId}) => AbstractRepositorySingleton.singleton.chatMemberInfoRepository(appId, roomId);
MemberHasChatRepository? memberHasChatRepository({ String? appId }) => AbstractRepositorySingleton.singleton.memberHasChatRepository(appId);
RoomRepository? roomRepository({ String? appId }) => AbstractRepositorySingleton.singleton.roomRepository(appId);

abstract class AbstractRepositorySingleton {
  static List<MemberCollectionInfo> collections = [
    MemberCollectionInfo('chat', 'authorId'),
    MemberCollectionInfo('chatmemberinfo', 'authorId'),
    MemberCollectionInfo('memberhaschat', 'memberId'),
    MemberCollectionInfo('room', 'authorId'),
  ];
  static late AbstractRepositorySingleton singleton;

  ChatRepository? chatRepository(String? appId, String? roomId);
  ChatDashboardRepository? chatDashboardRepository(String? appId);
  ChatMemberInfoRepository? chatMemberInfoRepository(String? appId, String? roomId);
  MemberHasChatRepository? memberHasChatRepository(String? appId);
  RoomRepository? roomRepository(String? appId);

  void flush(String? appId) {
    chatDashboardRepository(appId)!.flush();
    memberHasChatRepository(appId)!.flush();
    roomRepository(appId)!.flush();
  }
}
