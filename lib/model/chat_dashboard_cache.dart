/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_repository.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:eliud_core_model/tools/query/query_tools.dart';
import 'package:eliud_core_model/tools/common_tools.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';

import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core_model/model/cache_export.dart';
import 'package:eliud_pkg_chat/model/cache_export.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class ChatDashboardCache implements ChatDashboardRepository {

  final ChatDashboardRepository reference;
  final Map<String?, ChatDashboardModel?> fullCache = Map();

  ChatDashboardCache(this.reference);

  /**
   * Add a ChatDashboardModel to the repository, cached
   */
  Future<ChatDashboardModel> add(ChatDashboardModel value) {
    return reference.add(value).then((newValue) {
      fullCache[value.documentID] = newValue;
      return newValue;
    });
  }

  /**
   * Add a ChatDashboardEntity to the repository, cached
   */
  Future<ChatDashboardEntity> addEntity(String documentID, ChatDashboardEntity value) {
    return reference.addEntity(documentID, value);
  }

  /**
   * Update a ChatDashboardEntity in the repository, cached
   */
  Future<ChatDashboardEntity> updateEntity(String documentID, ChatDashboardEntity value) {
    return reference.updateEntity(documentID, value);
  }

  /**
   * Delete a ChatDashboardModel from the repository, cached
   */
  Future<void> delete(ChatDashboardModel value){
    fullCache.remove(value.documentID);
    reference.delete(value);
    return Future.value();
  }

  /**
   * Retrieve a ChatDashboardModel with it's id, cached
   */
  Future<ChatDashboardModel?> get(String? id, {Function(Exception)? onError}) async {
    var value = fullCache[id];
    if (value != null) return refreshRelations(value);
    value = await reference.get(id, onError: onError);
    fullCache[id] = value;
    return value;
  }

  /**
   * Update a ChatDashboardModel
   */
  Future<ChatDashboardModel> update(ChatDashboardModel value) {
    return reference.update(value).then((newValue) {
      fullCache[value.documentID] = newValue;
      return newValue;
    });
  }

  /**
   * Retrieve list of List<ChatDashboardModel?> 
   */
  @override
  Stream<List<ChatDashboardModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    return reference.values(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  Stream<List<ChatDashboardModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    return reference.valuesWithDetails(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  Future<List<ChatDashboardModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    return await reference.valuesList(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }
  
  @override
  Future<List<ChatDashboardModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    return await reference.valuesListWithDetails(orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, setLastDoc: setLastDoc, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  void flush() {
    fullCache.clear();
  }
  
  String? timeStampToString(dynamic timeStamp) {
    return reference.timeStampToString(timeStamp);
  } 

  dynamic getSubCollection(String documentId, String name) {
    return reference.getSubCollection(documentId, name);
  }

  Future<ChatDashboardModel> changeValue(String documentId, String fieldName, num changeByThisValue) {
    return reference.changeValue(documentId, fieldName, changeByThisValue).then((newValue) {
      fullCache[documentId] = newValue;
      return newValue!;
    });
  }

  @override
  Future<ChatDashboardEntity?> getEntity(String? id, {Function(Exception p1)? onError}) {
    return reference.getEntity(id, onError: onError);
  }

  @override
  ChatDashboardEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    return reference.fromMap(o, newDocumentIds: newDocumentIds);
  }

  Future<void> deleteAll() {
    return reference.deleteAll();
  }

  @override
  StreamSubscription<List<ChatDashboardModel?>> listen(trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    return reference.listen(trigger, orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  StreamSubscription<List<ChatDashboardModel?>> listenWithDetails(trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    return reference.listenWithDetails(trigger, orderBy: orderBy, descending: descending, startAfter: startAfter, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery);
  }

  @override
  StreamSubscription<ChatDashboardModel?> listenTo(String documentId, ChatDashboardChanged changed, {ChatDashboardErrorHandler? errorHandler}) {
    return reference.listenTo(documentId, ((value) {
      if (value != null) {
        fullCache[value.documentID] = value;
      }
      changed(value);
    }), errorHandler: errorHandler);
  }

  static Future<ChatDashboardModel> refreshRelations(ChatDashboardModel model) async {

    return model.copyWith(

    );
  }

}

