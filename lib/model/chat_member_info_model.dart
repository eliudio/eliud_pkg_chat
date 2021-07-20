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


import 'package:eliud_pkg_chat/model/chat_member_info_entity.dart';

import 'package:eliud_core/tools/random.dart';



class ChatMemberInfoModel {
  String? documentID;
  String? memberId;
  String? roomId;

  // Last Read entry in Chat in this room Timestamp
  String? timestamp;

  ChatMemberInfoModel({this.documentID, this.memberId, this.roomId, this.timestamp, })  {
    assert(documentID != null);
  }

  ChatMemberInfoModel copyWith({String? documentID, String? memberId, String? roomId, String? timestamp, }) {
    return ChatMemberInfoModel(documentID: documentID ?? this.documentID, memberId: memberId ?? this.memberId, roomId: roomId ?? this.roomId, timestamp: timestamp ?? this.timestamp, );
  }

  @override
  int get hashCode => documentID.hashCode ^ memberId.hashCode ^ roomId.hashCode ^ timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatMemberInfoModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          memberId == other.memberId &&
          roomId == other.roomId &&
          timestamp == other.timestamp;

  @override
  String toString() {
    return 'ChatMemberInfoModel{documentID: $documentID, memberId: $memberId, roomId: $roomId, timestamp: $timestamp}';
  }

  ChatMemberInfoEntity toEntity({String? appId}) {
    return ChatMemberInfoEntity(
          memberId: (memberId != null) ? memberId : null, 
          roomId: (roomId != null) ? roomId : null, 
          timestamp: timestamp, 
    );
  }

  static ChatMemberInfoModel? fromEntity(String documentID, ChatMemberInfoEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return ChatMemberInfoModel(
          documentID: documentID, 
          memberId: entity.memberId, 
          roomId: entity.roomId, 
          timestamp: entity.timestamp.toString(), 
    );
  }

  static Future<ChatMemberInfoModel?> fromEntityPlus(String documentID, ChatMemberInfoEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return ChatMemberInfoModel(
          documentID: documentID, 
          memberId: entity.memberId, 
          roomId: entity.roomId, 
          timestamp: entity.timestamp.toString(), 
    );
  }

}

