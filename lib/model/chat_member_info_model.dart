/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:collection/collection.dart';
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


import 'package:eliud_pkg_chat/model/chat_member_info_entity.dart';

import 'package:eliud_core_model/tools/etc/random.dart';

enum ChatMemberInfoAccessibleByGroup {
  public, followers, me, specificMembers, unknown
}


ChatMemberInfoAccessibleByGroup toChatMemberInfoAccessibleByGroup(int? index) {
  switch (index) {
    case 0: return ChatMemberInfoAccessibleByGroup.public;
    case 1: return ChatMemberInfoAccessibleByGroup.followers;
    case 2: return ChatMemberInfoAccessibleByGroup.me;
    case 3: return ChatMemberInfoAccessibleByGroup.specificMembers;
  }
  return ChatMemberInfoAccessibleByGroup.unknown;
}


class ChatMemberInfoModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_chat';
  static const String id = 'chatMemberInfos';

  String documentID;

  // The person who this info is about
  String authorId;

  // This is the identifier of the app to which this chat belongs
  String appId;
  String? roomId;

  // Last Read entry in Chat in this room for this member
  DateTime? timestamp;
  ChatMemberInfoAccessibleByGroup? accessibleByGroup;

  // In case accessibleByGroup == SpecificMembers, then these are the members
  List<String>? accessibleByMembers;
  List<String>? readAccess;

  ChatMemberInfoModel({required this.documentID, required this.authorId, required this.appId, this.roomId, this.timestamp, this.accessibleByGroup, this.accessibleByMembers, this.readAccess, })  {
    assert(documentID != null);
  }

  ChatMemberInfoModel copyWith({String? documentID, String? authorId, String? appId, String? roomId, DateTime? timestamp, ChatMemberInfoAccessibleByGroup? accessibleByGroup, List<String>? accessibleByMembers, List<String>? readAccess, }) {
    return ChatMemberInfoModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, appId: appId ?? this.appId, roomId: roomId ?? this.roomId, timestamp: timestamp ?? this.timestamp, accessibleByGroup: accessibleByGroup ?? this.accessibleByGroup, accessibleByMembers: accessibleByMembers ?? this.accessibleByMembers, readAccess: readAccess ?? this.readAccess, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ appId.hashCode ^ roomId.hashCode ^ timestamp.hashCode ^ accessibleByGroup.hashCode ^ accessibleByMembers.hashCode ^ readAccess.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatMemberInfoModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          authorId == other.authorId &&
          appId == other.appId &&
          roomId == other.roomId &&
          timestamp == other.timestamp &&
          accessibleByGroup == other.accessibleByGroup &&
          ListEquality().equals(accessibleByMembers, other.accessibleByMembers) &&
          ListEquality().equals(readAccess, other.readAccess);

  @override
  String toString() {
    String accessibleByMembersCsv = (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatMemberInfoModel{documentID: $documentID, authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }}';
  }

  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    return referencesCollector;
  }

  ChatMemberInfoEntity toEntity({String? appId}) {
    return ChatMemberInfoEntity(
          authorId: authorId, 
          appId: appId, 
          roomId: (roomId != null) ? roomId : null, 
          timestamp: (timestamp == null) ? null : timestamp!.millisecondsSinceEpoch, 
          accessibleByGroup: (accessibleByGroup != null) ? accessibleByGroup!.index : null, 
          accessibleByMembers: (accessibleByMembers != null) ? accessibleByMembers : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
    );
  }

  static Future<ChatMemberInfoModel?> fromEntity(String documentID, ChatMemberInfoEntity? entity) async {
    if (entity == null) return null;
    return ChatMemberInfoModel(
          documentID: documentID, 
          authorId: entity.authorId ?? '', 
          appId: entity.appId ?? '', 
          roomId: entity.roomId, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          accessibleByGroup: toChatMemberInfoAccessibleByGroup(entity.accessibleByGroup), 
          accessibleByMembers: entity.accessibleByMembers, 
          readAccess: entity.readAccess, 
    );
  }

  static Future<ChatMemberInfoModel?> fromEntityPlus(String documentID, ChatMemberInfoEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    return ChatMemberInfoModel(
          documentID: documentID, 
          authorId: entity.authorId ?? '', 
          appId: entity.appId ?? '', 
          roomId: entity.roomId, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          accessibleByGroup: toChatMemberInfoAccessibleByGroup(entity.accessibleByGroup), 
          accessibleByMembers: entity.accessibleByMembers, 
          readAccess: entity.readAccess, 
    );
  }

}

