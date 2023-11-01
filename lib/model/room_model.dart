/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/model_base.dart';

import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'package:eliud_pkg_chat/model/room_entity.dart';




class RoomModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_chat';
  static const String id = 'rooms';

  @override
  String documentID;

  // The person creating the room
  String ownerId;

  // This is the identifier of the app to which this feed belongs
  @override
  String appId;
  String? description;
  bool? isRoom;
  List<String>? members;
  DateTime? timestamp;

  RoomModel({required this.documentID, required this.ownerId, required this.appId, this.description, this.isRoom, this.members, this.timestamp, });

  @override
  RoomModel copyWith({String? documentID, String? ownerId, String? appId, String? description, bool? isRoom, List<String>? members, DateTime? timestamp, }) {
    return RoomModel(documentID: documentID ?? this.documentID, ownerId: ownerId ?? this.ownerId, appId: appId ?? this.appId, description: description ?? this.description, isRoom: isRoom ?? this.isRoom, members: members ?? this.members, timestamp: timestamp ?? this.timestamp, );
  }

  @override
  int get hashCode => documentID.hashCode ^ ownerId.hashCode ^ appId.hashCode ^ description.hashCode ^ isRoom.hashCode ^ members.hashCode ^ timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is RoomModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          ownerId == other.ownerId &&
          appId == other.appId &&
          description == other.description &&
          isRoom == other.isRoom &&
          const ListEquality().equals(members, other.members) &&
          timestamp == other.timestamp;

  @override
  String toString() {
    String membersCsv = (members == null) ? '' : members!.join(', ');

    return 'RoomModel{documentID: $documentID, ownerId: $ownerId, appId: $appId, description: $description, isRoom: $isRoom, members: String[] { $membersCsv }, timestamp: $timestamp}';
  }

  @override
  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    return referencesCollector;
  }

  @override
  RoomEntity toEntity({String? appId}) {
    return RoomEntity(
          ownerId: (ownerId != null) ? ownerId : null, 
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          isRoom: (isRoom != null) ? isRoom : null, 
          members: (members != null) ? members : null, 
          timestamp: (timestamp == null) ? null : timestamp!.millisecondsSinceEpoch, 
    );
  }

  static Future<RoomModel?> fromEntity(String documentID, RoomEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return RoomModel(
          documentID: documentID, 
          ownerId: entity.ownerId ?? '', 
          appId: entity.appId ?? '', 
          description: entity.description, 
          isRoom: entity.isRoom, 
          members: entity.members, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
    );
  }

  static Future<RoomModel?> fromEntityPlus(String documentID, RoomEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return RoomModel(
          documentID: documentID, 
          ownerId: entity.ownerId ?? '', 
          appId: entity.appId ?? '', 
          description: entity.description, 
          isRoom: entity.isRoom, 
          members: entity.members, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
    );
  }

}

