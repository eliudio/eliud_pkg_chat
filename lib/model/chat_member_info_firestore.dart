/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_firestore.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_pkg_chat/model/chat_member_info_repository.dart';

import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';

class ChatMemberInfoFirestore implements ChatMemberInfoRepository {
  @override
  ChatMemberInfoEntity? fromMap(Object? o,
      {Map<String, String>? newDocumentIds}) {
    return ChatMemberInfoEntity.fromMap(o, newDocumentIds: newDocumentIds);
  }

  @override
  Future<ChatMemberInfoEntity> addEntity(
      String documentID, ChatMemberInfoEntity value) {
    return chatMemberInfoCollection
        .doc(documentID)
        .set(value.toDocument())
        .then((_) => value)
        .then((v) async {
      var newValue = await getEntity(documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    });
  }

  @override
  Future<ChatMemberInfoEntity> updateEntity(
      String documentID, ChatMemberInfoEntity value) {
    return chatMemberInfoCollection
        .doc(documentID)
        .update(value.toDocument())
        .then((_) => value)
        .then((v) async {
      var newValue = await getEntity(documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    });
  }

  @override
  Future<ChatMemberInfoModel> add(ChatMemberInfoModel value) {
    return chatMemberInfoCollection
        .doc(value.documentID)
        .set(value
            .toEntity(appId: appId)
            .copyWith(
              timestamp: FieldValue.serverTimestamp(),
            )
            .toDocument())
        .then((_) => value)
        .then((v) async {
      var newValue = await get(value.documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    });
  }

  @override
  Future<void> delete(ChatMemberInfoModel value) {
    return chatMemberInfoCollection.doc(value.documentID).delete();
  }

  @override
  Future<ChatMemberInfoModel> update(ChatMemberInfoModel value) {
    return chatMemberInfoCollection
        .doc(value.documentID)
        .update(value
            .toEntity(appId: appId)
            .copyWith(
              timestamp: FieldValue.serverTimestamp(),
            )
            .toDocument())
        .then((_) => value)
        .then((v) async {
      var newValue = await get(value.documentID);
      if (newValue == null) {
        return value;
      } else {
        return newValue;
      }
    });
  }

  Future<ChatMemberInfoModel?> _populateDoc(DocumentSnapshot value) async {
    return ChatMemberInfoModel.fromEntity(
        value.id, ChatMemberInfoEntity.fromMap(value.data()));
  }

  Future<ChatMemberInfoModel?> _populateDocPlus(DocumentSnapshot value) async {
    return ChatMemberInfoModel.fromEntityPlus(
        value.id, ChatMemberInfoEntity.fromMap(value.data()),
        appId: appId);
  }

  @override
  Future<ChatMemberInfoEntity?> getEntity(String? id,
      {Function(Exception)? onError}) async {
    try {
      var collection = chatMemberInfoCollection.doc(id);
      var doc = await collection.get();
      return ChatMemberInfoEntity.fromMap(doc.data());
    } on Exception catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving ChatMemberInfo with id $id");
        print("Exceptoin: $e");
      }
    }
    return null;
  }

  @override
  Future<ChatMemberInfoModel?> get(String? id,
      {Function(Exception)? onError}) async {
    try {
      var collection = chatMemberInfoCollection.doc(id);
      var doc = await collection.get();
      return await _populateDocPlus(doc);
    } on Exception catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        print("Error whilst retrieving ChatMemberInfo with id $id");
        print("Exceptoin: $e");
      }
    }
    return null;
  }

  @override
  StreamSubscription<List<ChatMemberInfoModel?>> listen(
      ChatMemberInfoModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    Stream<List<ChatMemberInfoModel?>> stream;
    stream = getQuery(getCollection(),
            orderBy: orderBy,
            descending: descending,
            startAfter: startAfter as DocumentSnapshot?,
            limit: limit,
            privilegeLevel: privilegeLevel,
            eliudQuery: eliudQuery,
            appId: appId)!
        .snapshots()
//  see comment listen(...) above
//  stream = getQuery(chatMemberInfoCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(
          data.docs.map((doc) => _populateDoc(doc)).toList());
    });

    return stream.listen((listOfChatMemberInfoModels) {
      trigger(listOfChatMemberInfoModels);
    });
  }

  @override
  StreamSubscription<List<ChatMemberInfoModel?>> listenWithDetails(
      ChatMemberInfoModelTrigger trigger,
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    Stream<List<ChatMemberInfoModel?>> stream;
    stream = getQuery(getCollection(),
            orderBy: orderBy,
            descending: descending,
            startAfter: startAfter as DocumentSnapshot?,
            limit: limit,
            privilegeLevel: privilegeLevel,
            eliudQuery: eliudQuery,
            appId: appId)!
        .snapshots()
//  see comment listen(...) above
//  stream = getQuery(chatMemberInfoCollection, orderBy: orderBy,  descending: descending,  startAfter: startAfter as DocumentSnapshot?,  limit: limit, privilegeLevel: privilegeLevel, eliudQuery: eliudQuery, appId: appId)!.snapshots()
        .asyncMap((data) async {
      return await Future.wait(
          data.docs.map((doc) => _populateDocPlus(doc)).toList());
    });

    return stream.listen((listOfChatMemberInfoModels) {
      trigger(listOfChatMemberInfoModels);
    });
  }

  @override
  StreamSubscription<ChatMemberInfoModel?> listenTo(
      String documentId, ChatMemberInfoChanged changed,
      {ChatMemberInfoErrorHandler? errorHandler}) {
    var stream =
        chatMemberInfoCollection.doc(documentId).snapshots().asyncMap((data) {
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

  @override
  Stream<List<ChatMemberInfoModel?>> values(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    DocumentSnapshot? lastDoc;
    Stream<List<ChatMemberInfoModel?>> values = getQuery(
            chatMemberInfoCollection,
            orderBy: orderBy,
            descending: descending,
            startAfter: startAfter as DocumentSnapshot?,
            limit: limit,
            privilegeLevel: privilegeLevel,
            eliudQuery: eliudQuery,
            appId: appId)!
        .snapshots()
        .asyncMap((snapshot) {
      return Future.wait(snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return values;
  }

  @override
  Stream<List<ChatMemberInfoModel?>> valuesWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) {
    DocumentSnapshot? lastDoc;
    Stream<List<ChatMemberInfoModel?>> values = getQuery(
            chatMemberInfoCollection,
            orderBy: orderBy,
            descending: descending,
            startAfter: startAfter as DocumentSnapshot?,
            limit: limit,
            privilegeLevel: privilegeLevel,
            eliudQuery: eliudQuery,
            appId: appId)!
        .snapshots()
        .asyncMap((snapshot) {
      return Future.wait(snapshot.docs.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return values;
  }

  @override
  Future<List<ChatMemberInfoModel?>> valuesList(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) async {
    DocumentSnapshot? lastDoc;
    List<ChatMemberInfoModel?> values = await getQuery(chatMemberInfoCollection,
            orderBy: orderBy,
            descending: descending,
            startAfter: startAfter as DocumentSnapshot?,
            limit: limit,
            privilegeLevel: privilegeLevel,
            eliudQuery: eliudQuery,
            appId: appId)!
        .get()
        .then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {
        lastDoc = doc;
        return _populateDoc(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return values;
  }

  @override
  Future<List<ChatMemberInfoModel?>> valuesListWithDetails(
      {String? orderBy,
      bool? descending,
      Object? startAfter,
      int? limit,
      SetLastDoc? setLastDoc,
      int? privilegeLevel,
      EliudQuery? eliudQuery}) async {
    DocumentSnapshot? lastDoc;
    List<ChatMemberInfoModel?> values = await getQuery(chatMemberInfoCollection,
            orderBy: orderBy,
            descending: descending,
            startAfter: startAfter as DocumentSnapshot?,
            limit: limit,
            privilegeLevel: privilegeLevel,
            eliudQuery: eliudQuery,
            appId: appId)!
        .get()
        .then((value) {
      var list = value.docs;
      return Future.wait(list.map((doc) {
        lastDoc = doc;
        return _populateDocPlus(doc);
      }).toList());
    });
    if ((setLastDoc != null) && (lastDoc != null)) setLastDoc(lastDoc);
    return values;
  }

  @override
  void flush() {}

  @override
  Future<void> deleteAll() {
    return chatMemberInfoCollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  @override
  dynamic getSubCollection(String documentId, String name) {
    return chatMemberInfoCollection.doc(documentId).collection(name);
  }

  @override
  String? timeStampToString(dynamic timeStamp) {
    return firestoreTimeStampToString(timeStamp);
  }

  @override
  Future<ChatMemberInfoModel?> changeValue(
      String documentId, String fieldName, num changeByThisValue) {
    var change = FieldValue.increment(changeByThisValue);
    return chatMemberInfoCollection
        .doc(documentId)
        .update({fieldName: change}).then((v) => get(documentId));
  }

  final String appId;
  ChatMemberInfoFirestore(this.getCollection, this.appId)
      : chatMemberInfoCollection = getCollection();

  final CollectionReference chatMemberInfoCollection;
  final GetCollection getCollection;
}
