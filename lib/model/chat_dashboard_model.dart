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

import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'package:eliud_pkg_chat/model/chat_dashboard_entity.dart';

import 'package:eliud_core/tools/random.dart';



class ChatDashboardModel {
  String? documentID;

  // This is the identifier of the app to which this belongs
  String? appId;
  String? description;
  ConditionsSimpleModel? conditions;

  ChatDashboardModel({this.documentID, this.appId, this.description, this.conditions, })  {
    assert(documentID != null);
  }

  ChatDashboardModel copyWith({String? documentID, String? appId, String? description, ConditionsSimpleModel? conditions, }) {
    return ChatDashboardModel(documentID: documentID ?? this.documentID, appId: appId ?? this.appId, description: description ?? this.description, conditions: conditions ?? this.conditions, );
  }

  @override
  int get hashCode => documentID.hashCode ^ appId.hashCode ^ description.hashCode ^ conditions.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatDashboardModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          appId == other.appId &&
          description == other.description &&
          conditions == other.conditions;

  @override
  String toString() {
    return 'ChatDashboardModel{documentID: $documentID, appId: $appId, description: $description, conditions: $conditions}';
  }

  ChatDashboardEntity toEntity({String? appId}) {
    return ChatDashboardEntity(
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          conditions: (conditions != null) ? conditions!.toEntity(appId: appId) : null, 
    );
  }

  static ChatDashboardModel? fromEntity(String documentID, ChatDashboardEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return ChatDashboardModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          conditions: 
            ConditionsSimpleModel.fromEntity(entity.conditions), 
    );
  }

  static Future<ChatDashboardModel?> fromEntityPlus(String documentID, ChatDashboardEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return ChatDashboardModel(
          documentID: documentID, 
          appId: entity.appId, 
          description: entity.description, 
          conditions: 
            await ConditionsSimpleModel.fromEntityPlus(entity.conditions, appId: appId), 
    );
  }

}

