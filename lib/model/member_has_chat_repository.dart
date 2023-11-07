/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'dart:async';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/core/base/repository_base.dart';

typedef MemberHasChatModelTrigger = Function(List<MemberHasChatModel?> list);
typedef MemberHasChatChanged = Function(MemberHasChatModel? value);
typedef MemberHasChatErrorHandler = Function(dynamic o, dynamic e);

abstract class MemberHasChatRepository
    extends RepositoryBase<MemberHasChatModel, MemberHasChatEntity> {
  @override
  Future<MemberHasChatEntity> addEntity(
      String documentID, MemberHasChatEntity value);
  @override
  Future<MemberHasChatEntity> updateEntity(
      String documentID, MemberHasChatEntity value);
  @override
  Future<MemberHasChatModel> add(MemberHasChatModel value);
  @override
  Future<void> delete(MemberHasChatModel value);
  @override
  Future<MemberHasChatModel?> get(String? id, {Function(Exception)? onError});
  @override
  Future<MemberHasChatModel> update(MemberHasChatModel value);

  @override
  Stream<List<MemberHasChatModel?>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Stream<List<MemberHasChatModel?>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<MemberHasChatModel?>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  Future<List<MemberHasChatModel?>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery});

  @override
  StreamSubscription<List<MemberHasChatModel?>> listen(
      MemberHasChatModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<List<MemberHasChatModel?>> listenWithDetails(
      MemberHasChatModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery});
  @override
  StreamSubscription<MemberHasChatModel?> listenTo(
      String documentId, MemberHasChatChanged changed,
      {MemberHasChatErrorHandler? errorHandler});
  @override
  void flush();

  @override
  String? timeStampToString(dynamic timeStamp);

  @override
  dynamic getSubCollection(String documentId, String name);
  @override
  Future<MemberHasChatModel?> changeValue(
      String documentId, String fieldName, num changeByThisValue);

  @override
  Future<void> deleteAll();
}
