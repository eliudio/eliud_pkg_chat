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



import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef ChatMediumModelTrigger = Function(List<ChatMediumModel?> list);
typedef ChatMediumChanged = Function(ChatMediumModel? value);
typedef ChatMediumErrorHandler(o, e);

abstract class ChatMediumRepository extends RepositoryBase<ChatMediumModel, ChatMediumEntity> {
  @override
  Future<ChatMediumEntity> addEntity(String documentID, ChatMediumEntity value);
  @override
  Future<ChatMediumEntity> updateEntity(String documentID, ChatMediumEntity value);
  @override
  Future<ChatMediumModel> add(ChatMediumModel value);
  @override
  Future<void> delete(ChatMediumModel value);
  @override
  Future<ChatMediumModel?> get(String? id, { Function(Exception)? onError });
  @override
  Future<ChatMediumModel> update(ChatMediumModel value);

  @override
  Stream<List<ChatMediumModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  Stream<List<ChatMediumModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  Future<List<ChatMediumModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  Future<List<ChatMediumModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });

  @override
  StreamSubscription<List<ChatMediumModel?>> listen(ChatMediumModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  StreamSubscription<List<ChatMediumModel?>> listenWithDetails(ChatMediumModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  StreamSubscription<ChatMediumModel?> listenTo(String documentId, ChatMediumChanged changed, {ChatMediumErrorHandler? errorHandler});
  @override
  void flush();
  
  @override
  String? timeStampToString(dynamic timeStamp);

  @override
  dynamic getSubCollection(String documentId, String name);
  @override
  Future<ChatMediumModel?> changeValue(String documentId, String fieldName, num changeByThisValue);

  @override
  Future<void> deleteAll();
}


