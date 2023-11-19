/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_model.dart
                       
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


import 'package:eliud_pkg_chat/model/chat_entity.dart';

import 'package:eliud_core_model/tools/etc/random.dart';

enum ChatAccessibleByGroup {
  public, followers, me, specificMembers, unknown
}


ChatAccessibleByGroup toChatAccessibleByGroup(int? index) {
  switch (index) {
    case 0: return ChatAccessibleByGroup.public;
    case 1: return ChatAccessibleByGroup.followers;
    case 2: return ChatAccessibleByGroup.me;
    case 3: return ChatAccessibleByGroup.specificMembers;
  }
  return ChatAccessibleByGroup.unknown;
}


class ChatModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_chat';
  static const String id = 'chats';

  String documentID;

  // The person initiating the conversation, or the owner of the group
  String authorId;

  // This is the identifier of the app to which this chat belongs
  String appId;

  // This is the identifier of the room to which this chat belongs
  String? roomId;
  DateTime? timestamp;
  String? saying;
  ChatAccessibleByGroup? accessibleByGroup;

  // In case accessibleByGroup == SpecificMembers, then these are the members
  List<String>? accessibleByMembers;
  List<String>? readAccess;
  List<ChatMediumModel>? chatMedia;

  ChatModel({required this.documentID, required this.authorId, required this.appId, this.roomId, this.timestamp, this.saying, this.accessibleByGroup, this.accessibleByMembers, this.readAccess, this.chatMedia, })  {
    assert(documentID != null);
  }

  ChatModel copyWith({String? documentID, String? authorId, String? appId, String? roomId, DateTime? timestamp, String? saying, ChatAccessibleByGroup? accessibleByGroup, List<String>? accessibleByMembers, List<String>? readAccess, List<ChatMediumModel>? chatMedia, }) {
    return ChatModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, appId: appId ?? this.appId, roomId: roomId ?? this.roomId, timestamp: timestamp ?? this.timestamp, saying: saying ?? this.saying, accessibleByGroup: accessibleByGroup ?? this.accessibleByGroup, accessibleByMembers: accessibleByMembers ?? this.accessibleByMembers, readAccess: readAccess ?? this.readAccess, chatMedia: chatMedia ?? this.chatMedia, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ appId.hashCode ^ roomId.hashCode ^ timestamp.hashCode ^ saying.hashCode ^ accessibleByGroup.hashCode ^ accessibleByMembers.hashCode ^ readAccess.hashCode ^ chatMedia.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          authorId == other.authorId &&
          appId == other.appId &&
          roomId == other.roomId &&
          timestamp == other.timestamp &&
          saying == other.saying &&
          accessibleByGroup == other.accessibleByGroup &&
          ListEquality().equals(accessibleByMembers, other.accessibleByMembers) &&
          ListEquality().equals(readAccess, other.readAccess) &&
          ListEquality().equals(chatMedia, other.chatMedia);

  @override
  String toString() {
    String accessibleByMembersCsv = (accessibleByMembers == null) ? '' : accessibleByMembers!.join(', ');
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String chatMediaCsv = (chatMedia == null) ? '' : chatMedia!.join(', ');

    return 'ChatModel{documentID: $documentID, authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, saying: $saying, accessibleByGroup: $accessibleByGroup, accessibleByMembers: String[] { $accessibleByMembersCsv }, readAccess: String[] { $readAccessCsv }, chatMedia: ChatMedium[] { $chatMediaCsv }}';
  }

  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    if (chatMedia != null) {
      for (var item in chatMedia!) {
        referencesCollector.addAll(await item.collectReferences(appId: appId));
      }
    }
    return referencesCollector;
  }

  ChatEntity toEntity({String? appId}) {
    return ChatEntity(
          authorId: authorId, 
          appId: appId, 
          roomId: (roomId != null) ? roomId : null, 
          timestamp: (timestamp == null) ? null : timestamp!.millisecondsSinceEpoch, 
          saying: (saying != null) ? saying : null, 
          accessibleByGroup: (accessibleByGroup != null) ? accessibleByGroup!.index : null, 
          accessibleByMembers: (accessibleByMembers != null) ? accessibleByMembers : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
          chatMedia: (chatMedia != null) ? chatMedia
            !.map((item) => item.toEntity(appId: appId))
            .toList() : null, 
    );
  }

  static Future<ChatModel?> fromEntity(String documentID, ChatEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return ChatModel(
          documentID: documentID, 
          authorId: entity.authorId ?? '', 
          appId: entity.appId ?? '', 
          roomId: entity.roomId, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          saying: entity.saying, 
          accessibleByGroup: toChatAccessibleByGroup(entity.accessibleByGroup), 
          accessibleByMembers: entity.accessibleByMembers, 
          readAccess: entity.readAccess, 
          chatMedia: 
            entity.chatMedia == null ? null : List<ChatMediumModel>.from(await Future.wait(entity. chatMedia
            !.map((item) {
            counter++;
              return ChatMediumModel.fromEntity(counter.toString(), item);
            })
            .toList())), 
    );
  }

  static Future<ChatModel?> fromEntityPlus(String documentID, ChatEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return ChatModel(
          documentID: documentID, 
          authorId: entity.authorId ?? '', 
          appId: entity.appId ?? '', 
          roomId: entity.roomId, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          saying: entity.saying, 
          accessibleByGroup: toChatAccessibleByGroup(entity.accessibleByGroup), 
          accessibleByMembers: entity.accessibleByMembers, 
          readAccess: entity.readAccess, 
          chatMedia: 
            entity. chatMedia == null ? null : List<ChatMediumModel>.from(await Future.wait(entity. chatMedia
            !.map((item) {
            counter++;
            return ChatMediumModel.fromEntityPlus(counter.toString(), item, appId: appId);})
            .toList())), 
    );
  }

}

