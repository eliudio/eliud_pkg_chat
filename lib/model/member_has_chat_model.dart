/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eliud_core/core/base/model_base.dart';

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


import 'package:eliud_pkg_chat/model/member_has_chat_entity.dart';

import 'package:eliud_core/tools/random.dart';



class MemberHasChatModel implements ModelBase, WithAppId {
  String documentID;
  String memberId;

  // This is the identifier of the app to which this chat belongs
  String appId;
  bool? hasUnread;

  MemberHasChatModel({required this.documentID, required this.memberId, required this.appId, this.hasUnread, })  {
    assert(documentID != null);
  }

  MemberHasChatModel copyWith({String? documentID, String? memberId, String? appId, bool? hasUnread, }) {
    return MemberHasChatModel(documentID: documentID ?? this.documentID, memberId: memberId ?? this.memberId, appId: appId ?? this.appId, hasUnread: hasUnread ?? this.hasUnread, );
  }

  @override
  int get hashCode => documentID.hashCode ^ memberId.hashCode ^ appId.hashCode ^ hasUnread.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is MemberHasChatModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          memberId == other.memberId &&
          appId == other.appId &&
          hasUnread == other.hasUnread;

  @override
  String toString() {
    return 'MemberHasChatModel{documentID: $documentID, memberId: $memberId, appId: $appId, hasUnread: $hasUnread}';
  }

  MemberHasChatEntity toEntity({String? appId}) {
    return MemberHasChatEntity(
          memberId: (memberId != null) ? memberId : null, 
          appId: (appId != null) ? appId : null, 
          hasUnread: (hasUnread != null) ? hasUnread : null, 
    );
  }

  static Future<MemberHasChatModel?> fromEntity(String documentID, MemberHasChatEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return MemberHasChatModel(
          documentID: documentID, 
          memberId: entity.memberId ?? '', 
          appId: entity.appId ?? '', 
          hasUnread: entity.hasUnread, 
    );
  }

  static Future<MemberHasChatModel?> fromEntityPlus(String documentID, MemberHasChatEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return MemberHasChatModel(
          documentID: documentID, 
          memberId: entity.memberId ?? '', 
          appId: entity.appId ?? '', 
          hasUnread: entity.hasUnread, 
    );
  }

}

