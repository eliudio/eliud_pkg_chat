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

import 'package:eliud_pkg_chat/model/member_has_chat_repository.dart';


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

typedef MemberHasChatModelTrigger(List<MemberHasChatModel?> list);
typedef MemberHasChatChanged(MemberHasChatModel? value);
typedef MemberHasChatErrorHandler = Function(dynamic o, dynamic e);

abstract class MemberHasChatRepository extends RepositoryBase<MemberHasChatModel, MemberHasChatEntity> {
  Future<MemberHasChatEntity> addEntity(String documentID, MemberHasChatEntity value);
  Future<MemberHasChatEntity> updateEntity(String documentID, MemberHasChatEntity value);
  Future<MemberHasChatModel> add(MemberHasChatModel value);
  Future<void> delete(MemberHasChatModel value);
  Future<MemberHasChatModel?> get(String? id, { Function(Exception)? onError });
  Future<MemberHasChatModel> update(MemberHasChatModel value);

  Stream<List<MemberHasChatModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Stream<List<MemberHasChatModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<MemberHasChatModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });
  Future<List<MemberHasChatModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery });

  StreamSubscription<List<MemberHasChatModel?>> listen(MemberHasChatModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<List<MemberHasChatModel?>> listenWithDetails(MemberHasChatModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery });
  StreamSubscription<MemberHasChatModel?> listenTo(String documentId, MemberHasChatChanged changed, {MemberHasChatErrorHandler? errorHandler});
  void flush();
  
  String? timeStampToString(dynamic timeStamp);

  dynamic getSubCollection(String documentId, String name);
  Future<MemberHasChatModel?> changeValue(String documentId, String fieldName, num changeByThisValue);

  Future<void> deleteAll();
}


