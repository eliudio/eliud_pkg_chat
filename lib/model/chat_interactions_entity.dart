/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class ChatInteractionsEntity {
  final String? authorId;
  final String? appId;
  final String? details;
  final List<String>? readAccess;

  ChatInteractionsEntity({this.authorId, this.appId, this.details, this.readAccess, });


  List<Object?> get props => [authorId, appId, details, readAccess, ];

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatInteractionsEntity{authorId: $authorId, appId: $appId, details: $details, readAccess: String[] { $readAccessCsv }}';
  }

  static ChatInteractionsEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return ChatInteractionsEntity(
      authorId: map['authorId'], 
      appId: map['appId'], 
      details: map['details'], 
      readAccess: map['readAccess'] == null ? null : List.from(map['readAccess']), 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (details != null) theDocument["details"] = details;
      else theDocument["details"] = null;
    if (readAccess != null) theDocument["readAccess"] = readAccess!.toList();
      else theDocument["readAccess"] = null;
    return theDocument;
  }

  static ChatInteractionsEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

