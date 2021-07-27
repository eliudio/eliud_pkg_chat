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

  // The person initiating the conversation, or the owner of the group
  String? authorId;

  // This is the identifier of the app to which this chat belongs
  String? appId;
  String? roomId;

  // Last Read entry in Chat in this room for this member
  String? timestamp;
  List<String>? readAccess;

  ChatMemberInfoModel({this.documentID, this.authorId, this.appId, this.roomId, this.timestamp, this.readAccess, })  {
    assert(documentID != null);
  }

  ChatMemberInfoModel copyWith({String? documentID, String? authorId, String? appId, String? roomId, String? timestamp, List<String>? readAccess, }) {
    return ChatMemberInfoModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, appId: appId ?? this.appId, roomId: roomId ?? this.roomId, timestamp: timestamp ?? this.timestamp, readAccess: readAccess ?? this.readAccess, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ appId.hashCode ^ roomId.hashCode ^ timestamp.hashCode ^ readAccess.hashCode;

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
          ListEquality().equals(readAccess, other.readAccess);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatMemberInfoModel{documentID: $documentID, authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, readAccess: String[] { $readAccessCsv }}';
  }

  ChatMemberInfoEntity toEntity({String? appId}) {
    return ChatMemberInfoEntity(
          authorId: (authorId != null) ? authorId : null, 
          appId: (appId != null) ? appId : null, 
          roomId: (roomId != null) ? roomId : null, 
          timestamp: timestamp, 
          readAccess: (readAccess != null) ? readAccess : null, 
    );
  }

  static ChatMemberInfoModel? fromEntity(String documentID, ChatMemberInfoEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return ChatMemberInfoModel(
          documentID: documentID, 
          authorId: entity.authorId, 
          appId: entity.appId, 
          roomId: entity.roomId, 
          timestamp: entity.timestamp.toString(), 
          readAccess: entity.readAccess, 
    );
  }

  static Future<ChatMemberInfoModel?> fromEntityPlus(String documentID, ChatMemberInfoEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return ChatMemberInfoModel(
          documentID: documentID, 
          authorId: entity.authorId, 
          appId: entity.appId, 
          roomId: entity.roomId, 
          timestamp: entity.timestamp.toString(), 
          readAccess: entity.readAccess, 
    );
  }

}

