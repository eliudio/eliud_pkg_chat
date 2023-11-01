/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/core/base/entity_base.dart';
import 'package:eliud_core/model/entity_export.dart';

class ChatDashboardEntity implements EntityBase {
  final String? appId;
  final String? description;
  final StorageConditionsEntity? conditions;
  final int? membersType;

  ChatDashboardEntity({required this.appId, this.description, this.conditions, this.membersType, });

  ChatDashboardEntity copyWith({String? documentID, String? appId, String? description, StorageConditionsEntity? conditions, int? membersType, }) {
    return ChatDashboardEntity(appId : appId ?? this.appId, description : description ?? this.description, conditions : conditions ?? this.conditions, membersType : membersType ?? this.membersType, );
  }
  List<Object?> get props => [appId, description, conditions, membersType, ];

  @override
  String toString() {
    return 'ChatDashboardEntity{appId: $appId, description: $description, conditions: $conditions, membersType: $membersType}';
  }

  static ChatDashboardEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var conditionsFromMap;
    conditionsFromMap = map['conditions'];
    if (conditionsFromMap != null) {
      conditionsFromMap = StorageConditionsEntity.fromMap(conditionsFromMap, newDocumentIds: newDocumentIds);
    }

    return ChatDashboardEntity(
      appId: map['appId'], 
      description: map['description'], 
      conditions: conditionsFromMap, 
      membersType: map['membersType'], 
    );
  }

  @override
  Map<String, Object?> toDocument() {
    final Map<String, dynamic>? conditionsMap = conditions != null 
        ? conditions!.toDocument()
        : null;

    Map<String, Object?> theDocument = HashMap();
    if (appId != null) {
      theDocument["appId"] = appId;
    } else {
      theDocument["appId"] = null;
    }
    if (description != null) {
      theDocument["description"] = description;
    } else {
      theDocument["description"] = null;
    }
    if (conditions != null) {
      theDocument["conditions"] = conditionsMap;
    } else {
      theDocument["conditions"] = null;
    }
    if (membersType != null) {
      theDocument["membersType"] = membersType;
    } else {
      theDocument["membersType"] = null;
    }
    return theDocument;
  }

  @override
  ChatDashboardEntity switchAppId({required String newAppId}) {
    var newEntity = copyWith(appId: newAppId);
    return newEntity;
  }

  static ChatDashboardEntity? fromJsonString(String json, {Map<String, String>? newDocumentIds}) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap, newDocumentIds: newDocumentIds);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

  @override
  Future<Map<String, Object?>> enrichedDocument(Map<String, Object?> theDocument) async {
    return theDocument;
  }

}

