/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_firestore.dart
                       
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core_model/tools/query/query_tools.dart';
import 'package:eliud_core_model/tools/firestore/firestore_tools.dart';
import 'package:eliud_core_model/tools/common_tools.dart';

/* 
 * MemberHasChatFirestore is the firestore implementation of MemberHasChatRepository
 */
class MemberHasChatFirestore implements MemberHasChatRepository {
  /* 
   * transform a map into an entity
   */
  @override
  MemberHasChatEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    return MemberHasChatEntity.fromMap(o, newDocumentIds: newDocumentIds);
  }

  /* 
   * add an entity to the repository
   */
  Future<MemberHasChatEntity> addEntity(String documentID, MemberHasChatEntity value) {
    return memberHasChatCollection.doc(documentID).set(value.toDocument()).then((_) => value);
  }

  /* 
   * Update an entity
   */
  Future<MemberHasChatEntity> updateEntity(String documentID, MemberHasChatEntity value) {
    return memberHasChatCollection.doc(documentID).update(value.toDocument()).then((_) => value);
  }

  /* 
   * Add a model to the repository
   */
  Future<MemberHasChatModel> add(MemberHasChatModel value) {
    return memberHasChatCollection.doc(value.documentID).set(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  /* 
   * Delete a model
   */
  Future<void> delete(MemberHasChatModel value) {
    return memberHasChatCollection.doc(value.documentID).delete();
  }

  /* 
   * Update a model
   */
  Future<MemberHasChatModel> update(MemberHasChatModel value) {
    return memberHasChatCollection.doc(value.documentID).update(value.toEntity(appId: appId).toDocument()).then((_) => value);
  }

  Future<MemberHasChatModel?> _populateDoc(DocumentSnapshot value) async {
    return MemberHasChatModel.fromEntity(value.id, MemberHasChatEntity.fromMap(value.data()));
  }

  Future<MemberHasChatModel?> _populateDocPlus(DocumentSnapshot value) async {
    return MemberHasChatModel.fromEntityPlus(value.id, MemberHasChatEntity.fromMap(value.data()), appId: appId);  }

  /* 
   * Retrieve an entity from the repository with id
   */
  Future<MemberHasChatEntity?> getEntity(String? id, {Function(Exception)? onError}) async {
    try {
      var collection = memberHasChatCollection.doc(id);
      var doc = await collection.get();
      return MemberHasChatEntity.fromMap(doc.data());
    } on Exception catch(e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving MemberHasChat with id $id");
        print("Exceptoin: $e");
      }
    };
  }

  /* 
   * Retrieve an model from the repository with id
   */
  Future<MemberHasChatModel?> get(String? id, {Function(Exception)? onError}) async {
    try {
      var collection = memberHasChatCollection.doc(id);
      var doc = await collection.get();
      return await _populateDocPlus(doc);
    } on Exception catch(e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving MemberHasChat with id $id");
        print("Exceptoin: $e");
      }
    };
  }

  /* 
   * Listen to the repository using a query. Retrieve models
   */
  StreamSubscription<List<MemberHasChatModel?>> listen(MemberHasChatModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<MemberHasChatModel?>> stream;
    stream = getQuery(getCollection(), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
//  see comment listen(...) above
//  stream = getQuery(memberHasChatCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDoc(doc)).toList());
    });

    return stream.listen((listOfMemberHasChatModels) {
      trigger(listOfMemberHasChatModels);
    });
  }

  /* 
   * Listen to the repository using a query. Retrieve models and linked models
   */
  StreamSubscription<List<MemberHasChatModel?>> listenWithDetails(MemberHasChatModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<MemberHasChatModel?>> stream;
    stream = getQuery(getCollection(), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
//  see comment listen(...) above
//  stream = getQuery(memberHasChatCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfMemberHasChatModels) {
      trigger(listOfMemberHasChatModels);
    });
  }

  /* 
   * Listen to 1 document in the repository
   */
  @override
  StreamSubscription<MemberHasChatModel?> listenTo(String documentId, MemberHasChatChanged changed, {MemberHasChatErrorHandler? errorHandler}) {
    var stream = memberHasChatCollection.doc(documentId)
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
  Stream<List<MemberHasChatModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<MemberHasChatModel?>> _values = getQuery(memberHasChatCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().asyncMap((snapshot) {
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
  Stream<List<MemberHasChatModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<MemberHasChatModel?>> _values = getQuery(memberHasChatCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().asyncMap((snapshot) {
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
  Future<List<MemberHasChatModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<MemberHasChatModel?> _values = await getQuery(memberHasChatCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
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
  Future<List<MemberHasChatModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<MemberHasChatModel?> _values = await getQuery(memberHasChatCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
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
    return memberHasChatCollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  }

  /* 
   * Retrieve the subcollection of this repository
   */
  dynamic getSubCollection(String documentId, String name) {
    return memberHasChatCollection.doc(documentId).collection(name);
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
  Future<MemberHasChatModel?> changeValue(String documentId, String fieldName, num changeByThisValue) {
    var change = FieldValue.increment(changeByThisValue);
    return memberHasChatCollection.doc(documentId).update({fieldName: change}).then((v) => get(documentId));
  }


  final String appId;
  MemberHasChatFirestore(this.getCollection, this.appId): memberHasChatCollection = getCollection();

  final CollectionReference memberHasChatCollection;
  final GetCollection getCollection;
}

