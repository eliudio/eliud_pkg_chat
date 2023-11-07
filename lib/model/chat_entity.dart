/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/entity_base.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class ChatEntity implements EntityBase {
  final String? authorId;
  final String? appId;
  final String? roomId;
  final Object? timestamp;
  final String? saying;
  final int? accessibleByGroup;
  final List<String>? accessibleByMembers;
  final List<String>? readAccess;
  final List<ChatMediumEntity>? chatMedia;

  ChatEntity({
    required this.authorId,
    required this.appId,
    this.roomId,
    this.timestamp,
    this.saying,
    this.accessibleByGroup,
    this.accessibleByMembers,
    this.readAccess,
    this.chatMedia,
  });

  ChatEntity copyWith({
    String? documentID,
    String? authorId,
    String? appId,
    String? roomId,
    Object? timestamp,
    String? saying,
    int? accessibleByGroup,
    List<String>? accessibleByMembers,
    List<String>? readAccess,
    List<ChatMediumEntity>? chatMedia,
  }) {
    return ChatEntity(
      authorId: authorId ?? this.authorId,
      appId: appId ?? this.appId,
      roomId: roomId ?? this.roomId,
      timestamp: timestamp ?? this.timestamp,
      saying: saying ?? this.saying,
      accessibleByGroup: accessibleByGroup ?? this.accessibleByGroup,
      accessibleByMembers: accessibleByMembers ?? this.accessibleByMembers,
      readAccess: readAccess ?? this.readAccess,
      chatMedia: chatMedia ?? this.chatMedia,
    );
  }

  List<Object?> get props => [
        authorId,
        appId,
        roomId,
        timestamp,
        saying,
        accessibleByGroup,
        accessibleByMembers,
        readAccess,
        chatMedia,
      ];

  @override
  String toString() {
    String accessibleByMembersCsv =
        (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String chatMediaCsv = (chatMedia == null) ? '' : chatMedia!.join(', ');

    return 'ChatEntity{authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, saying: $saying, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }, chatMedia: ChatMedium[] { $chatMediaCsv }}';
  }

  static ChatEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var chatMediaFromMap = map['chatMedia'];
    List<ChatMediumEntity> chatMediaList;
    if (chatMediaFromMap != null) {
      chatMediaList = (map['chatMedia'] as List<dynamic>)
          .map((dynamic item) => ChatMediumEntity.fromMap(item as Map,
              newDocumentIds: newDocumentIds)!)
          .toList();
    } else {
      chatMediaList = [];
    }

    return ChatEntity(
      authorId: map['authorId'],
      appId: map['appId'],
      roomId: map['roomId'],
      timestamp: map['timestamp'] == null
          ? null
          : (map['timestamp'] as Timestamp).millisecondsSinceEpoch,
      saying: map['saying'],
      accessibleByGroup: map['accessibleByGroup'],
      accessibleByMembers: map['accessibleByMembers'] == null
          ? null
          : List.from(map['accessibleByMembers']),
      readAccess:
          map['readAccess'] == null ? null : List.from(map['readAccess']),
      chatMedia: chatMediaList,
    );
  }

  @override
  Map<String, Object?> toDocument() {
    final List<Map<String?, dynamic>>? chatMediaListMap = chatMedia != null
        ? chatMedia!.map((item) => item.toDocument()).toList()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (authorId != null) {
      theDocument["authorId"] = authorId;
    } else {
      theDocument["authorId"] = null;
    }
    if (appId != null) {
      theDocument["appId"] = appId;
    } else {
      theDocument["appId"] = null;
    }
    if (roomId != null) {
      theDocument["roomId"] = roomId;
    } else {
      theDocument["roomId"] = null;
    }
    theDocument["timestamp"] = timestamp;
    if (saying != null) {
      theDocument["saying"] = saying;
    } else {
      theDocument["saying"] = null;
    }
    if (accessibleByGroup != null) {
      theDocument["accessibleByGroup"] = accessibleByGroup;
    } else {
      theDocument["accessibleByGroup"] = null;
    }
    if (accessibleByMembers != null) {
      theDocument["accessibleByMembers"] = accessibleByMembers!.toList();
    } else {
      theDocument["accessibleByMembers"] = null;
    }
    if (readAccess != null) {
      theDocument["readAccess"] = readAccess!.toList();
    } else {
      theDocument["readAccess"] = null;
    }
    if (chatMedia != null) {
      theDocument["chatMedia"] = chatMediaListMap;
    } else {
      theDocument["chatMedia"] = null;
    }
    return theDocument;
  }

  @override
  ChatEntity switchAppId({required String newAppId}) {
    var newEntity = copyWith(appId: newAppId);
    return newEntity;
  }

  static ChatEntity? fromJsonString(String json,
      {Map<String, String>? newDocumentIds}) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap, newDocumentIds: newDocumentIds);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

  @override
  Future<Map<String, Object?>> enrichedDocument(
      Map<String, Object?> theDocument) async {
    return theDocument;
  }
}
