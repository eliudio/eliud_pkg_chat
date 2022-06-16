/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_firestore.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_chat/model/room_repository.dart';


import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';

class RoomFirestore implements RoomRepository {
  Future<RoomEntity> addEntity(String documentID, RoomEntity value) {
    return RoomCollection.doc(documentID).set(value.toDocument()).then((_) => value).then((v) async {
      var newValue = await getEntity(documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    })
;
  }

  Future<RoomEntity> updateEntity(String documentID, RoomEntity value) {
    return RoomCollection.doc(documentID).update(value.toDocument()).then((_) => value).then((v) async {
      var newValue = await getEntity(documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    })
;
  }

  Future<RoomModel> add(RoomModel value) {
    return RoomCollection.doc(value.documentID).set(value.toEntity(appId: appId).copyWith(timestamp : FieldValue.serverTimestamp(), ).toDocument()).then((_) => value).then((v) async {
      var newValue = await get(value.documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    })
;
  }

  Future<void> delete(RoomModel value) {
    return RoomCollection.doc(value.documentID).delete();
  }

  Future<RoomModel> update(RoomModel value) {
    return RoomCollection.doc(value.documentID).update(value.toEntity(appId: appId).copyWith(timestamp : FieldValue.serverTimestamp(), ).toDocument()).then((_) => value).then((v) async {
      var newValue = await get(value.documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    })
;
  }

  Future<RoomModel?> _populateDoc(DocumentSnapshot value) async {
    return RoomModel.fromEntity(value.id, RoomEntity.fromMap(value.data()));
  }

  Future<RoomModel?> _populateDocPlus(DocumentSnapshot value) async {
    return RoomModel.fromEntityPlus(value.id, RoomEntity.fromMap(value.data()), appId: appId);  }

  Future<RoomEntity?> getEntity(String? id, {Function(Exception)? onError}) async {
    try {
      var collection = RoomCollection.doc(id);
      var doc = await collection.get();
      return RoomEntity.fromMap(doc.data());
    } on Exception catch(e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving Room with id $id");
        print("Exceptoin: $e");
      }
    };
  }

  Future<RoomModel?> get(String? id, {Function(Exception)? onError}) async {
    try {
      var collection = RoomCollection.doc(id);
      var doc = await collection.get();
      return await _populateDocPlus(doc);
    } on Exception catch(e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving Room with id $id");
        print("Exceptoin: $e");
      }
    };
  }

  StreamSubscription<List<RoomModel?>> listen(RoomModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<RoomModel?>> stream;
    stream = getQuery(getCollection(), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
//  see comment listen(...) above
//  stream = getQuery(RoomCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDoc(doc)).toList());
    });

    return stream.listen((listOfRoomModels) {
      trigger(listOfRoomModels);
    });
  }

  StreamSubscription<List<RoomModel?>> listenWithDetails(RoomModelTrigger trigger, {String? orderBy, bool? descending, Object? startAfter, int? limit, int? privilegeLevel, EliudQuery? eliudQuery}) {
    Stream<List<RoomModel?>> stream;
    stream = getQuery(getCollection(), orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
//  see comment listen(...) above
//  stream = getQuery(RoomCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(data.docs.map((doc) =>  _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfRoomModels) {
      trigger(listOfRoomModels);
    });
  }

  @override
  StreamSubscription<RoomModel?> listenTo(String documentId, RoomChanged changed) {
    var stream = RoomCollection.doc(documentId)
        .snapshots()
        .asyncMap((data) {
      return _populateDocPlus(data);
    });
    return stream.listen((value) {
      changed(value);
    });
  }

  Stream<List<RoomModel?>> values({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<RoomModel?>> _values = getQuery(RoomCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().asyncMap((snapshot) {
      return Future.wait(snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  Stream<List<RoomModel?>> valuesWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) {
    DocumentSnapshot? lastDoc;
    Stream<List<RoomModel?>> _values = getQuery(RoomCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?, limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots().asyncMap((snapshot) {
      return Future.wait(snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  Future<List<RoomModel?>> valuesList({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<RoomModel?> _values = await getQuery(RoomCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  Future<List<RoomModel?>> valuesListWithDetails({String? orderBy, bool? descending, Object? startAfter, int? limit, SetLastDoc? setLastDoc, int? privilegeLevel, EliudQuery? eliudQuery }) async {
    DocumentSnapshot? lastDoc;
    List<RoomModel?> _values = await getQuery(RoomCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.get().then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return _values;
  }

  void flush() {}

  Future<void> deleteAll() {
    return RoomCollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  }

  dynamic getSubCollection(String documentId, String name) {
    return RoomCollection.doc(documentId).collection(name);
  }

  String? timeStampToString(dynamic timeStamp) {
    return firestoreTimeStampToString(timeStamp);
  } 

  Future<RoomModel?> changeValue(String documentId, String fieldName, num changeByThisValue) {
    var change = FieldValue.increment(changeByThisValue);
    return RoomCollection.doc(documentId).update({fieldName: change}).then((v) => get(documentId));
  }


  final String appId;
  RoomFirestore(this.getCollection, this.appId): RoomCollection = getCollection();

  final CollectionReference RoomCollection;
  final GetCollection getCollection;
}

