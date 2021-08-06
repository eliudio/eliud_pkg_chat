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
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class ChatMemberInfoEntity {
  final String? authorId;
  final String? appId;
  final String? roomId;
  final Object? timestamp;
  final List<String>? readAccess;

  ChatMemberInfoEntity({this.authorId, this.appId, this.roomId, this.timestamp, this.readAccess, });

  ChatMemberInfoEntity copyWith({Object? timestamp, }) {
    return ChatMemberInfoEntity(authorId: authorId, appId: appId, roomId: roomId, timestamp : timestamp, readAccess: readAccess, );
  }
  List<Object?> get props => [authorId, appId, roomId, timestamp, readAccess, ];

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatMemberInfoEntity{authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, readAccess: String[] { $readAccessCsv }}';
  }

  static ChatMemberInfoEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return ChatMemberInfoEntity(
      authorId: map['authorId'], 
      appId: map['appId'], 
      roomId: map['roomId'], 
      timestamp: map['timestamp'] == null ? null : (map['timestamp']  as Timestamp).millisecondsSinceEpoch,
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (roomId != null) theDocument["roomId"] = roomId;
      else theDocument["roomId"] = null;
    theDocument["timestamp"] = timestamp;
    if (readAccess != null) theDocument["readAccess"] = readAccess!.toList();
      else theDocument["readAccess"] = null;
    return theDocument;
  }

  static ChatMemberInfoEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

