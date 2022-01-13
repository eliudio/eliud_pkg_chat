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
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class ChatEntity {
  final String? authorId;
  final String? appId;
  final String? roomId;
  final Object? timestamp;
  final String? saying;
  final int? accessibleByGroup;
  final List<String>? accessibleByMembers;
  final List<String>? readAccess;
  final List<ChatMediumEntity>? chatMedia;

  ChatEntity({this.authorId, this.appId, this.roomId, this.timestamp, this.saying, this.accessibleByGroup, this.accessibleByMembers, this.readAccess, this.chatMedia, });

  ChatEntity copyWith({Object? timestamp, }) {
    return ChatEntity(authorId: authorId, appId: appId, roomId: roomId, timestamp : timestamp, saying: saying, accessibleByGroup: accessibleByGroup, accessibleByMembers: accessibleByMembers, readAccess: readAccess, chatMedia: chatMedia, );
  }
  List<Object?> get props => [authorId, appId, roomId, timestamp, saying, accessibleByGroup, accessibleByMembers, readAccess, chatMedia, ];

  @override
  String toString() {
    String accessibleByMembersCsv = (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String chatMediaCsv = (chatMedia == null) ? '' : chatMedia!.join(', ');

    return 'ChatEntity{authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, saying: $saying, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }, chatMedia: ChatMedium[] { $chatMediaCsv }}';
  }

  static ChatEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var chatMediaFromMap;
    chatMediaFromMap = map['chatMedia'];
    var chatMediaList;
    if (chatMediaFromMap != null)
      chatMediaList = (map['chatMedia'] as List<dynamic>)
        .map((dynamic item) =>
        ChatMediumEntity.fromMap(item as Map)!)
        .toList();

    return ChatEntity(
      authorId: map['authorId'], 
      appId: map['appId'], 
      roomId: map['roomId'], 
      timestamp: map['timestamp'] == null ? null : (map['timestamp']  as Timestamp).millisecondsSinceEpoch,
      saying: map['saying'], 
      accessibleByGroup: map['accessibleByGroup'], 
      accessibleByMembers: map['accessibleByMembers'] == null ? null : List.from(map['accessibleByMembers']), 
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
      chatMedia: chatMediaList, 
    );
  }

  Map<String, Object?> toDocument() {
    final List<Map<String?, dynamic>>? chatMediaListMap = chatMedia != null 
        ? chatMedia!.map((item) => item.toDocument()).toList()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (roomId != null) theDocument["roomId"] = roomId;
      else theDocument["roomId"] = null;
    theDocument["timestamp"] = timestamp;
    if (saying != null) theDocument["saying"] = saying;
      else theDocument["saying"] = null;
    if (accessibleByGroup != null) theDocument["accessibleByGroup"] = accessibleByGroup;
      else theDocument["accessibleByGroup"] = null;
    if (accessibleByMembers != null) theDocument["accessibleByMembers"] = accessibleByMembers!.toList();
      else theDocument["accessibleByMembers"] = null;
    if (readAccess != null) theDocument["readAccess"] = readAccess!.toList();
      else theDocument["readAccess"] = null;
    if (chatMedia != null) theDocument["chatMedia"] = chatMediaListMap;
      else theDocument["chatMedia"] = null;
    return theDocument;
  }

  static ChatEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

