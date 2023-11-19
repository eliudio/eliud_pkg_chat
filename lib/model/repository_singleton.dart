/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/repository_singleton.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'dart:collection';
import '../model/chat_firestore.dart';
import '../model/chat_repository.dart';
import '../model/chat_cache.dart';
import '../model/chat_dashboard_firestore.dart';
import '../model/chat_dashboard_repository.dart';
import '../model/chat_dashboard_cache.dart';
import '../model/chat_medium_repository.dart';
import '../model/chat_medium_cache.dart';
import '../model/chat_member_info_firestore.dart';
import '../model/chat_member_info_repository.dart';
import '../model/chat_member_info_cache.dart';
import '../model/member_has_chat_firestore.dart';
import '../model/member_has_chat_repository.dart';
import '../model/member_has_chat_cache.dart';
import '../model/room_firestore.dart';
import '../model/room_repository.dart';
import '../model/room_cache.dart';

import '../model/chat_medium_model.dart';

class RepositorySingleton extends AbstractRepositorySingleton {
    var _chatRepository = HashMap<String, ChatRepository>();
    var _chatDashboardRepository = HashMap<String, ChatDashboardRepository>();
    var _chatMemberInfoRepository = HashMap<String, ChatMemberInfoRepository>();
    var _memberHasChatRepository = HashMap<String, MemberHasChatRepository>();
    var _roomRepository = HashMap<String, RoomRepository>();

    ChatRepository? chatRepository(String? appId, String? roomId) {
      var key = appId == null || roomId == null ? null : appId + '-' + roomId;
      if ((key != null) && (_chatRepository[key] == null)) { _chatRepository[key] = ChatCache(ChatFirestore(() => roomRepository(appId)!.getSubCollection(roomId!, 'chat'), appId!));}
      return _chatRepository[key]; 
    }
    ChatDashboardRepository? chatDashboardRepository(String? appId) {
      if ((appId != null) && (_chatDashboardRepository[appId] == null)) { _chatDashboardRepository[appId] = ChatDashboardCache(ChatDashboardFirestore(() => appRepository()!.getSubCollection(appId, 'chatdashboard'), appId)); }
      return _chatDashboardRepository[appId];
    }
    ChatMemberInfoRepository? chatMemberInfoRepository(String? appId, String? roomId) {
      var key = appId == null || roomId == null ? null : appId + '-' + roomId;
      if ((key != null) && (_chatMemberInfoRepository[key] == null)) { _chatMemberInfoRepository[key] = ChatMemberInfoCache(ChatMemberInfoFirestore(() => roomRepository(appId)!.getSubCollection(roomId!, 'chatmemberinfo'), appId!));}
      return _chatMemberInfoRepository[key]; 
    }
    MemberHasChatRepository? memberHasChatRepository(String? appId) {
      if ((appId != null) && (_memberHasChatRepository[appId] == null)) { _memberHasChatRepository[appId] = MemberHasChatCache(MemberHasChatFirestore(() => appRepository()!.getSubCollection(appId, 'memberhaschat'), appId)); }
      return _memberHasChatRepository[appId];
    }
    RoomRepository? roomRepository(String? appId) {
      if ((appId != null) && (_roomRepository[appId] == null)) { _roomRepository[appId] = RoomCache(RoomFirestore(() => appRepository()!.getSubCollection(appId, 'room'), appId)); }
      return _roomRepository[appId];
    }

}
