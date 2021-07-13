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
import '../model/room_repository.dart';
import 'package:eliud_core/core/access/bloc/user_repository.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core/package/package.dart';

ChatRepository? chatRepository({ String? appId }) => AbstractRepositorySingleton.singleton.chatRepository(appId);
ChatDashboardRepository? chatDashboardRepository({ String? appId }) => AbstractRepositorySingleton.singleton.chatDashboardRepository(appId);
RoomRepository? roomRepository({ String? appId }) => AbstractRepositorySingleton.singleton.roomRepository(appId);

abstract class AbstractRepositorySingleton {
  static List<MemberCollectionInfo> collections = [
    MemberCollectionInfo('chat', 'authorId'),
    MemberCollectionInfo('room', 'authorId'),
  ];
  static late AbstractRepositorySingleton singleton;

  ChatRepository? chatRepository(String? appId);
  ChatDashboardRepository? chatDashboardRepository(String? appId);
  RoomRepository? roomRepository(String? appId);

  void flush(String? appId) {
  }
}
