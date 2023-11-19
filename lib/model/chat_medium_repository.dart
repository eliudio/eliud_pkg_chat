/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_chat/model/chat_medium_repository.dart';


import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'dart:async';
import 'package:eliud_core_model/tools/query/query_tools.dart';
import 'package:eliud_core_model/tools/common_tools.dart';
import 'package:eliud_core_model/tools/base/repository_base.dart';

typedef ChatMediumModelTrigger(List<ChatMediumModel?> list);
typedef ChatMediumChanged(ChatMediumModel? value);
typedef ChatMediumErrorHandler = Function(dynamic o, dynamic e);

abstract class ChatMediumRepository extends RepositoryBase<ChatMediumModel, ChatMediumEntity> {
  Future<ChatMediumEntity> addEntity(String documentID, ChatMediumEntity value);
  Future<ChatMediumEntity> updateEntity(String documentID, ChatMediumEntity value);
  Future<ChatMediumModel> add(ChatMediumModel value);
  Future<void> delete(ChatMediumModel value);
  Future<ChatMediumModel?> get(String? id, { Function(Exception)? onError });
  Future<ChatMediumModel> update(ChatMediumModel value);

  Stream<List<ChatMediumModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Stream<List<ChatMediumModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<ChatMediumModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<ChatMediumModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });

  StreamSubscription<List<ChatMediumModel?>> listen(ChatMediumModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<List<ChatMediumModel?>> listenWithDetails(ChatMediumModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<ChatMediumModel?> listenTo(String documentId, ChatMediumChanged changed, {ChatMediumErrorHandler? errorHandler});
  void flush();
  
  String? timeStampToString(dynamic timeStamp);

  dynamic getSubCollection(String documentId, String name);
  Future<ChatMediumModel?> changeValue(String documentId, String fieldName, num changeByThisValue);

  Future<void> deleteAll();
}


