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
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class ChatEntity {
  final String? authorId;
  final String? appId;
  final Object? timestamp;
  final String? saying;
  final List<String>? readAccess;

  ChatEntity({this.authorId, this.appId, this.timestamp, this.saying, this.readAccess, });

  ChatEntity copyWith({Object? timestamp, }) {
    return ChatEntity(authorId: authorId, appId: appId, timestamp : timestamp, saying: saying, readAccess: readAccess, );
  }
  List<Object?> get props => [authorId, appId, timestamp, saying, readAccess, ];

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatEntity{authorId: $authorId, appId: $appId, timestamp: $timestamp, saying: $saying, readAccess: String[] { $readAccessCsv }}';
  }

  static ChatEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return ChatEntity(
      authorId: map['authorId'], 
      appId: map['appId'], 
      timestamp: chatRepository(appId: map['appId'])!.timeStampToString(map['timestamp']), 
      saying: map['saying'], 
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    theDocument["timestamp"] = timestamp;
    if (saying != null) theDocument["saying"] = saying;
      else theDocument["saying"] = null;
    if (readAccess != null) theDocument["readAccess"] = readAccess!.toList();
      else theDocument["readAccess"] = null;
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

