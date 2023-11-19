/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core_model/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core_model/tools/base/model_base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eliud_core_model/model/app_model.dart';

import 'package:eliud_core_model/model/repository_export.dart';
import 'package:eliud_core_model/model/abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core_model/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core_model/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'package:eliud_pkg_chat/model/chat_dashboard_entity.dart';

import 'package:eliud_core_model/tools/etc/random.dart';

enum MembersType {
  followingMembers, allMembers, unknown
}


MembersType toMembersType(int? index) {
  switch (index) {
    case 0: return MembersType.followingMembers;
    case 1: return MembersType.allMembers;
  }
  return MembersType.unknown;
}


class ChatDashboardModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_chat';
  static const String id = 'chatDashboards';

  String documentID;

  // This is the identifier of the app to which this belongs
  String appId;
  String? description;
  StorageConditionsModel? conditions;
  MembersType? membersType;

  ChatDashboardModel({required this.documentID, required this.appId, this.description, this.conditions, this.membersType, })  {
    assert(documentID != null);
  }

  ChatDashboardModel copyWith({String? documentID, String? appId, String? description, StorageConditionsModel? conditions, MembersType? membersType, }) {
    return ChatDashboardModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, conditions: conditions ?? this.conditions, membersType: membersType ?? this.membersType, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ conditions.hashCode ^ membersType.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatDashboardModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          conditions == other.conditions &&
          membersType == other.membersType;

  @override
  String toString() {
    return 'ChatDashboardModel{documentID: $documentID, appId: $appId, description: $description, conditions: $conditions, membersType: $membersType}';
  }

  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    if (conditions != null) { referencesCollector.addAll(await conditions!.collectReferences(appId: appId)); }
    return referencesCollector;
  }

  ChatDashboardEntity toEntity({String? appId}) {
    return ChatDashboardEntity(
          appId: appId, 
          description: (description != null) ? description : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
          membersType: (membersType != null) ? membersType!.index : null, 
    );
  }

  static Future<ChatDashboardModel?> fromEntity(String documentID, ChatDashboardEntity? entity) async {
    if (entity == null) return null;
    return ChatDashboardModel(
          documentID: documentID, 
          appId: entity.appId ?? '', 
          description: entity.description, 
          conditions: 
            await StorageConditionsModel.fromEntity(entity.conditions), 
          membersType: toMembersType(entity.membersType), 
    );
  }

  static Future<ChatDashboardModel?> fromEntityPlus(String documentID, ChatDashboardEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    return ChatDashboardModel(
          documentID: documentID, 
          appId: entity.appId ?? '', 
          description: entity.description, 
          conditions: 
            await StorageConditionsModel.fromEntityPlus(entity.conditions, appId: appId), 
          membersType: toMembersType(entity.membersType), 
    );
  }

}

