/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/



import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef ChatMemberInfoModelTrigger = Function(List<ChatMemberInfoModel?> list);
typedef ChatMemberInfoChanged = Function(ChatMemberInfoModel? value);
typedef ChatMemberInfoErrorHandler(o, e);

abstract class ChatMemberInfoRepository extends RepositoryBase<ChatMemberInfoModel, ChatMemberInfoEntity> {
  @override
  Future<ChatMemberInfoEntity> addEntity(String documentID, ChatMemberInfoEntity value);
  @override
  Future<ChatMemberInfoEntity> updateEntity(String documentID, ChatMemberInfoEntity value);
  @override
  Future<ChatMemberInfoModel> add(ChatMemberInfoModel value);
  @override
  Future<void> delete(ChatMemberInfoModel value);
  @override
  Future<ChatMemberInfoModel?> get(String? id, { Function(Exception)? onError });
  @override
  Future<ChatMemberInfoModel> update(ChatMemberInfoModel value);

  @override
  Stream<List<ChatMemberInfoModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  Stream<List<ChatMemberInfoModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  Future<List<ChatMemberInfoModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  Future<List<ChatMemberInfoModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });

  @override
  StreamSubscription<List<ChatMemberInfoModel?>> listen(ChatMemberInfoModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  StreamSubscription<List<ChatMemberInfoModel?>> listenWithDetails(ChatMemberInfoModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  @override
  StreamSubscription<ChatMemberInfoModel?> listenTo(String documentId, ChatMemberInfoChanged changed, {ChatMemberInfoErrorHandler? errorHandler});
  @override
  void flush();
  
  @override
  String? timeStampToString(dynamic timeStamp);

  @override
  dynamic getSubCollection(String documentId, String name);
  @override
  Future<ChatMemberInfoModel?> changeValue(String documentId, String fieldName, num changeByThisValue);

  @override
  Future<void> deleteAll();
}


