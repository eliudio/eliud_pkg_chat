/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_firestore.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_chat/model/chat_dashboard_repository.dart';


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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core_model/tools/query/query_tools.dart';
import 'package:eliud_core_model/tools/firestore/firestore_tools.dart';
import 'package:eliud_core_model/tools/common_tools.dart';

/* 
 * ChatDashboardFirestore is the firestore implementation of ChatDashboardRepository
 */
class ChatDashboardFirestore implements ChatDashboardRepository {
  /* 
   * transform a map into an entity
   */
  @override
  ChatDashboardEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    return ChatDashboardEntity.fromMap(o, newDocumentIds: newDocumentIds);
  }

  /* 
   * add an entity to the repository
   */
  Future<ChatDashboardEntity> addEntity(String documentID, ChatDashboardEntity value) {
    return chatDashboardCollection.doc(documentID).set(value.toDocument()).then((_) => value);
  }

  /* 
   * Update an entity
   */
  Future<ChatDashboardEntity> updateEntity(String documentID, ChatDashboardEntity value) {
    return chatDashboardCollection.doc(documentID).update(value.toDocument()).then((_) => value);
  }

  /* 
   * Add a model to the repository
   */
  Future<ChatDashboardModel> add(ChatDashboardModel value) {
    return chatDashboardCollection.doc(value.documentID).set(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  /* 
   * Delete a model
   */
  Future<void> delete(ChatDashboardModel value) {
    return chatDashboardCollection.doc(value.documentID).delete();
  }

  /* 
   * Update a model
   */
  Future<ChatDashboardModel> update(ChatDashboardModel value) {
    return chatDashboardCollection.doc(value.documentID).update(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  Future<ChatDashboardModel?> _populateDoc(DocumentSnapshot value) async {
    return ChatDashboardModel.fromEntity(value.id, ChatDashboardEntity.fromMap(value.data()));
  }

  Future<ChatDashboardModel?> _populateDocPlus(DocumentSnapshot value) async {
    return ChatDashboardModel.fromEntityPlus(value.id, ChatDashboardEntity.fromMap(value.data()), appId: appId);  }

  /* 
   * Retrieve an entity from the repository with id
   */
  Future<ChatDashboardEntity?> getEntity(String? id, {Function(Exception)? onError}) async {
    try {
      var collection = chatDashboardCollection.doc(id);
      var doc = await collection.get();
      return ChatDashboardEntity.fromMap(doc.data());
    } on Exception catch(e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving ChatDashboard with id $id");
        print("Exceptoin: $e");
      }
    };
  }

  /* 
   * Retrieve an model from the repository with id
   */
  Future<ChatDashboardModel?> get(String? id, {Function(Exception)? onError}) async {
    try {
      var collection = chatDashboardCollection.doc(id);
      var doc = await collection.get();
      return await _populateDocPlus(doc);
    } on Exception catch(e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving ChatDashboard with id $id");
        print("Exceptoin: $e");
      }
    };
  }

  /* 
   * Listen to the repository using a query. Retrieve models
   */
  StreamSubscription<List<ChatDashboardModel?>> listen(ChatDashboardModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<ChatDashboardModel?>> stream;
    stream = getQuery(getCollection(), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
//  see comment listen(...) above
//  stream = getQuery(chatDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDoc(doc)).toList());
    });

    return stream.listen((listOfChatDashboardModels) {
      trigger(listOfChatDashboardModels);
    });
  }

  /* 
   * Listen to the repository using a query. Retrieve models and linked models
   */
  StreamSubscription<List<ChatDashboardModel?>> listenWithDetails(ChatDashboardModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<ChatDashboardModel?>> stream;
    stream = getQuery(getCollection(), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
//  see comment listen(...) above
//  stream = getQuery(chatDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfChatDashboardModels) {
      trigger(listOfChatDashboardModels);
    });
  }

  /* 
   * Listen to 1 document in the repository
   */
  @override
  StreamSubscription<ChatDashboardModel?> listenTo(String documentId, ChatDashboardChanged changed, {ChatDashboardErrorHandler? errorHandler}) {
    var stream = chatDashboardCollection.doc(documentId)
        .snapshots()
        .asyncMap((data) {
      return _populateDocPlus(data);
    });
    var theStream = stream.listen((value) {
      changed(value);
    });
    theStream.onError((theException, theStacktrace) {
      if (errorHandler != null) {
        errorHandler(theException, theStacktrace);
      }
    });
    return theStream;
  }

  /* 
   * Retrieve values/models from the repository
   */
  Stream<List<ChatDashboardModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<ChatDashboardModel?>> _values = getQuery(chatDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().asyncMap((snapshot) {
      return Future.wait(snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  /* 
   * Retrieve values/models, including linked models, from the repository
   */
  Stream<List<ChatDashboardModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<ChatDashboardModel?>> _values = getQuery(chatDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().asyncMap((snapshot) {
      return Future.wait(snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  /* 
   * Retrieve values/models from the repository
   */
  Future<List<ChatDashboardModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<ChatDashboardModel?> _values = await getQuery(chatDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  /* 
   * Retrieve values/models, including linked models, from the repository
   */
  Future<List<ChatDashboardModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<ChatDashboardModel?> _values = await getQuery(chatDashboardCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  /* 
   * Flush the repository
   */
  void flush() {}

  /* 
   * Delete all entries in the repository
   */
  Future<void> deleteAll() {
    return chatDashboardCollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  }

  /* 
   * Retrieve the subcollection of this repository
   */
  dynamic getSubCollection(String documentId, String name) {
    return chatDashboardCollection.doc(documentId).collection(name);
  }

  /* 
   * Retrieve a timestamp
   */
  String? timeStampToString(dynamic timeStamp) {
    return firestoreTimeStampToString(timeStamp);
  } 

  /* 
   * change 1 a fieldvalue for 1 document  
   */
  Future<ChatDashboardModel?> changeValue(String documentId, String fieldName, num changeByThisValue) {
    var change = FieldValue.increment(changeByThisValue);
    return chatDashboardCollection.doc(documentId).update({fieldName: change}).then((v) => get(documentId));
  }


  final String appId;
  ChatDashboardFirestore(this.getCollection, this.appId): chatDashboardCollection = getCollection();

  final CollectionReference chatDashboardCollection;
  final GetCollection getCollection;
}

