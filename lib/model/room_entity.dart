/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class RoomEntity {
  final String? ownerId;
  final String? appId;
  final String? description;
  final List<String>? members;

  RoomEntity({this.ownerId, this.appId, this.description, this.members, });


  List<Object?> get props => [ownerId, appId, description, members, ];

  @override
  String toString() {
    String membersCsv = (members == null) ? '' : members!.join(', ');

    return 'RoomEntity{ownerId: $ownerId, appId: $appId, description: $description, members: String[] { $membersCsv }}';
  }

  static RoomEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return RoomEntity(
      ownerId: map['ownerId'], 
      appId: map['appId'], 
      description: map['description'], 
      members: map['members'] == null ? null : List.from(map['members']), 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (ownerId != null) theDocument["ownerId"] = ownerId;
      else theDocument["ownerId"] = null;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (description != null) theDocument["description"] = description;
      else theDocument["description"] = null;
    if (members != null) theDocument["members"] = members!.toList();
      else theDocument["members"] = null;
    return theDocument;
  }

  static RoomEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

