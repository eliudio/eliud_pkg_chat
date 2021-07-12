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
  final String? description;
  final List<String>? members;

  ChatEntity({this.authorId, this.appId, this.description, this.members, });


  List<Object?> get props => [authorId, appId, description, members, ];

  @override
  String toString() {
    String membersCsv = (members == null) ? '' : members!.join(', ');

    return 'ChatEntity{authorId: $authorId, appId: $appId, description: $description, members: String[] { $membersCsv }}';
  }

  static ChatEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return ChatEntity(
      authorId: map['authorId'], 
      appId: map['appId'], 
      description: map['description'], 
      members: map['members'] == null ? null : List.from(map['members']), 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (authorId != null) theDocument["authorId"] = authorId;
      else theDocument["authorId"] = null;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (members != null) theDocument["members"] = members!.toList();
      else theDocument["members"] = null;
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

