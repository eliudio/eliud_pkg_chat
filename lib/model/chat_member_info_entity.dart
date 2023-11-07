/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/entity_base.dart';

class ChatMemberInfoEntity implements EntityBase {
  final String? authorId;
  final String? appId;
  final String? roomId;
  final Object? timestamp;
  final int? accessibleByGroup;
  final List<String>? accessibleByMembers;
  final List<String>? readAccess;

  ChatMemberInfoEntity({
    required this.authorId,
    required this.appId,
    this.roomId,
    this.timestamp,
    this.accessibleByGroup,
    this.accessibleByMembers,
    this.readAccess,
  });

  ChatMemberInfoEntity copyWith({
    String? documentID,
    String? authorId,
    String? appId,
    String? roomId,
    Object? timestamp,
    int? accessibleByGroup,
    List<String>? accessibleByMembers,
    List<String>? readAccess,
  }) {
    return ChatMemberInfoEntity(
      authorId: authorId ?? this.authorId,
      appId: appId ?? this.appId,
      roomId: roomId ?? this.roomId,
      timestamp: timestamp ?? this.timestamp,
      accessibleByGroup: accessibleByGroup ?? this.accessibleByGroup,
      accessibleByMembers: accessibleByMembers ?? this.accessibleByMembers,
      readAccess: readAccess ?? this.readAccess,
    );
  }

  List<Object?> get props => [
        authorId,
        appId,
        roomId,
        timestamp,
        accessibleByGroup,
        accessibleByMembers,
        readAccess,
      ];

  @override
  String toString() {
    String accessibleByMembersCsv =
        (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatMemberInfoEntity{authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }}';
  }

  static ChatMemberInfoEntity? fromMap(Object? o,
      {Map<String, String>? newDocumentIds}) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return ChatMemberInfoEntity(
      authorId: map['authorId'],
      appId: map['appId'],
      roomId: map['roomId'],
      timestamp: map['timestamp'] == null
          ? null
          : (map['timestamp'] as Timestamp).millisecondsSinceEpoch,
      accessibleByGroup: map['accessibleByGroup'],
      accessibleByMembers: map['accessibleByMembers'] == null
          ? null
          : List.from(map['accessibleByMembers']),
      readAccess:
          map['readAccess'] == null ? null : List.from(map['readAccess']),
    );
  }

  @override
  Map<String, Object?> toDocument() {
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
    return theDocument;
  }

  @override
  ChatMemberInfoEntity switchAppId({required String newAppId}) {
    var newEntity = copyWith(appId: newAppId);
    return newEntity;
  }

  static ChatMemberInfoEntity? fromJsonString(String json,
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
