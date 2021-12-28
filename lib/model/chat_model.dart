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
import 'package:eliud_core/tools/common_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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


import 'package:eliud_pkg_chat/model/chat_entity.dart';

import 'package:eliud_core/tools/random.dart';



class ChatModel {
  String? documentID;

  // The person initiating the conversation, or the owner of the group
  String? authorId;

  // This is the identifier of the app to which this chat belongs
  String? appId;

  // This is the identifier of the room to which this chat belongs
  String? roomId;
  DateTime? timestamp;
  String? saying;
  List<String>? readAccess;
  List<ChatMediumModel>? chatMedia;

  ChatModel({this.documentID, this.authorId, this.appId, this.roomId, this.timestamp, this.saying, this.readAccess, this.chatMedia, })  {
    assert(documentID != null);
  }

  ChatModel copyWith({String? documentID, String? authorId, String? appId, String? roomId, DateTime? timestamp, String? saying, List<String>? readAccess, List<ChatMediumModel>? chatMedia, }) {
    return ChatModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, appId: appId ?? this.appId, roomId: roomId ?? this.roomId, timestamp: timestamp ?? this.timestamp, saying: saying ?? this.saying, readAccess: readAccess ?? this.readAccess, chatMedia: chatMedia ?? this.chatMedia, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ appId.hashCode ^ roomId.hashCode ^ timestamp.hashCode ^ saying.hashCode ^ readAccess.hashCode ^ chatMedia.hashCode;

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
          ListEquality().equals(readAccess, other.readAccess) &&
          ListEquality().equals(chatMedia, other.chatMedia);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');
    String chatMediaCsv = (chatMedia == null) ? '' : chatMedia!.join(', ');

    return 'ChatModel{documentID: $documentID, authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, saying: $saying, readAccess: String[] { $readAccessCsv }, chatMedia: ChatMedium[] { $chatMediaCsv }}';
  }

  ChatEntity toEntity({String? appId}) {
    return ChatEntity(
          authorId: (authorId != null) ? authorId : null, 
          appId: (appId != null) ? appId : null, 
          roomId: (roomId != null) ? roomId : null, 
          timestamp: (timestamp == null) ? null : timestamp!.millisecondsSinceEpoch, 
          saying: (saying != null) ? saying : null, 
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
          authorId: entity.authorId, 
          appId: entity.appId, 
          roomId: entity.roomId, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          saying: entity.saying, 
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
          authorId: entity.authorId, 
          appId: entity.appId, 
          roomId: entity.roomId, 
          timestamp: entity.timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch((entity.timestamp as int)), 
          saying: entity.saying, 
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

