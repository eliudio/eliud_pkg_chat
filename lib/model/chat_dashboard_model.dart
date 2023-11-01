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

import 'package:eliud_core/core/base/model_base.dart';

import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'package:eliud_pkg_chat/model/chat_dashboard_entity.dart';


enum MembersType {
  FollowingMembers, AllMembers, Unknown
}


MembersType toMembersType(int? index) {
  switch (index) {
    case 0: return MembersType.FollowingMembers;
    case 1: return MembersType.AllMembers;
  }
  return MembersType.Unknown;
}


class ChatDashboardModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_chat';
  static const String id = 'chatDashboards';

  @override
  String documentID;

  // This is the identifier of the app to which this belongs
  @override
  String appId;
  String? description;
  StorageConditionsModel? conditions;
  MembersType? membersType;

  ChatDashboardModel({required this.documentID, required this.appId, this.description, this.conditions, this.membersType, });

  @override
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

  @override
  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    if (conditions != null) referencesCollector.addAll(await conditions!.collectReferences(appId: appId));
    return referencesCollector;
  }

  @override
  ChatDashboardEntity toEntity({String? appId}) {
    return ChatDashboardEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
          membersType: (membersType != null) ? membersType!.index : null, 
    );
  }

  static Future<ChatDashboardModel?> fromEntity(String documentID, ChatDashboardEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
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

    var counter = 0;
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

