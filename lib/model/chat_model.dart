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
  String? timestamp;
  String? saying;
  List<String>? readAccess;

  ChatModel({this.documentID, this.authorId, this.appId, this.roomId, this.timestamp, this.saying, this.readAccess, })  {
    assert(documentID != null);
  }

  ChatModel copyWith({String? documentID, String? authorId, String? appId, String? roomId, String? timestamp, String? saying, List<String>? readAccess, }) {
    return ChatModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, appId: appId ?? this.appId, roomId: roomId ?? this.roomId, timestamp: timestamp ?? this.timestamp, saying: saying ?? this.saying, readAccess: readAccess ?? this.readAccess, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ appId.hashCode ^ roomId.hashCode ^ timestamp.hashCode ^ saying.hashCode ^ readAccess.hashCode;

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
          ListEquality().equals(readAccess, other.readAccess);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatModel{documentID: $documentID, authorId: $authorId, appId: $appId, roomId: $roomId, timestamp: $timestamp, saying: $saying, readAccess: String[] { $readAccessCsv }}';
  }

  ChatEntity toEntity({String? appId}) {
    return ChatEntity(
          authorId: (authorId != null) ? authorId : null, 
          appId: (appId != null) ? appId : null, 
          roomId: (roomId != null) ? roomId : null, 
          timestamp: timestamp, 
          saying: (saying != null) ? saying : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
    );
  }

  static ChatModel? fromEntity(String documentID, ChatEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return ChatModel(
          documentID: documentID, 
          authorId: entity.authorId, 
          appId: entity.appId, 
          roomId: entity.roomId, 
          timestamp: entity.timestamp.toString(), 
          saying: entity.saying, 
          readAccess: entity.readAccess, 
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
          timestamp: entity.timestamp.toString(), 
          saying: entity.saying, 
          readAccess: entity.readAccess, 
    );
  }

}

