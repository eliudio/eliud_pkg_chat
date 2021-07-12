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

  // This is the identifier of the app to which this feed belongs
  String? appId;
  String? description;
  List<String>? members;

  ChatModel({this.documentID, this.authorId, this.appId, this.description, this.members, })  {
    assert(documentID != null);
  }

  ChatModel copyWith({String? documentID, String? authorId, String? appId, String? description, List<String>? members, }) {
    return ChatModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, appId: appId ?? this.appId, description: description ?? this.description, members: members ?? this.members, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ appId.hashCode ^ description.hashCode ^ members.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          authorId == other.authorId &&
          appId == other.appId &&
          description == other.description &&
          ListEquality().equals(members, other.members);

  @override
  String toString() {
    String membersCsv = (members == null) ? '' : members!.join(', ');

    return 'ChatModel{documentID: $documentID, authorId: $authorId, appId: $appId, description: $description, members: String[] { $membersCsv }}';
  }

  ChatEntity toEntity({String? appId}) {
    return ChatEntity(
          authorId: (authorId != null) ? authorId : null, 
          appId: (appId != null) ? appId : null, 
          description: (description != null) ? description : null, 
          members: (members != null) ? members : null, 
    );
  }

  static ChatModel? fromEntity(String documentID, ChatEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return ChatModel(
          documentID: documentID, 
          authorId: entity.authorId, 
          appId: entity.appId, 
          description: entity.description, 
          members: entity.members, 
    );
  }

  static Future<ChatModel?> fromEntityPlus(String documentID, ChatEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return ChatModel(
          documentID: documentID, 
          authorId: entity.authorId, 
          appId: entity.appId, 
          description: entity.description, 
          members: entity.members, 
    );
  }

}

