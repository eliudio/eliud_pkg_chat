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
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'dart:collection';
import '../model/chat_firestore.dart';
import '../model/chat_repository.dart';
import '../model/chat_cache.dart';
import '../model/chat_dashboard_firestore.dart';
import '../model/chat_dashboard_repository.dart';
import '../model/chat_dashboard_cache.dart';
import '../model/chat_interactions_firestore.dart';
import '../model/chat_interactions_repository.dart';
import '../model/chat_interactions_cache.dart';


class RepositorySingleton extends AbstractRepositorySingleton {
    var _chatRepository = HashMap<String, ChatRepository>();
    var _chatDashboardRepository = HashMap<String, ChatDashboardRepository>();
    var _chatInteractionsRepository = HashMap<String, ChatInteractionsRepository>();

    ChatRepository? chatRepository(String? appId) {
      if ((appId != null) && (_chatRepository[appId] == null)) _chatRepository[appId] = ChatCache(ChatFirestore(appRepository()!.getSubCollection(appId, 'chat'), appId));
      return _chatRepository[appId];
    }
    ChatDashboardRepository? chatDashboardRepository(String? appId) {
      if ((appId != null) && (_chatDashboardRepository[appId] == null)) _chatDashboardRepository[appId] = ChatDashboardCache(ChatDashboardFirestore(appRepository()!.getSubCollection(appId, 'chatdashboard'), appId));
      return _chatDashboardRepository[appId];
    }
    ChatInteractionsRepository? chatInteractionsRepository(String? appId) {
      if ((appId != null) && (_chatInteractionsRepository[appId] == null)) _chatInteractionsRepository[appId] = ChatInteractionsCache(ChatInteractionsFirestore(appRepository()!.getSubCollection(appId, 'chatinteractions'), appId));
      return _chatInteractionsRepository[appId];
    }

}
