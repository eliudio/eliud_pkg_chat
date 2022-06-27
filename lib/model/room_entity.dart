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
import 'abstract_repository_singleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/entity_base.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'package:eliud_core/tools/common_tools.dart';
class RoomEntity implements EntityBase {
  final String? ownerId;
  final String? appId;
  final String? description;
  final bool? isRoom;
  final List<String>? members;
  final Object? timestamp;

  RoomEntity({required this.ownerId, required this.appId, this.description, this.isRoom, this.members, this.timestamp, });

  RoomEntity copyWith({Object? timestamp, }) {
    return RoomEntity(ownerId: ownerId, appId: appId, description: description, isRoom: isRoom, members: members, timestamp : timestamp, );
  }
  List<Object?> get props => [ownerId, appId, description, isRoom, members, timestamp, ];

  @override
  String toString() {
    String membersCsv = (members == null) ? '' : members!.join(', ');

    return 'RoomEntity{ownerId: $ownerId, appId: $appId, description: $description, isRoom: $isRoom, members: String[] { $membersCsv }, timestamp: $timestamp}';
  }

  static RoomEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return RoomEntity(
      ownerId: map['ownerId'], 
      appId: map['appId'], 
      description: map['description'], 
      isRoom: map['isRoom'], 
      members: map['members'] == null ? null : List.from(map['members']), 
      timestamp: map['timestamp'] == null ? null : (map['timestamp']  as Timestamp).millisecondsSinceEpoch,
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
    if (isRoom != null) theDocument["isRoom"] = isRoom;
      else theDocument["isRoom"] = null;
    if (members != null) theDocument["members"] = members!.toList();
      else theDocument["members"] = null;
    theDocument["timestamp"] = timestamp;
    return theDocument;
  }

  static RoomEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

  Future<Map<String, Object?>> enrichedDocument(Map<String, Object?> theDocument) async {
    return theDocument;
  }

}

