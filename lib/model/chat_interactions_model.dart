/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_model.dart
                       
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


import 'package:eliud_pkg_chat/model/chat_interactions_entity.dart';

import 'package:eliud_core/tools/random.dart';



class ChatInteractionsModel {
  String? documentID;

  // The person initiating the conversation, or the owner of the group
  String? authorId;

  // This is the identifier of the app to which this feed belongs
  String? appId;
  String? details;
  List<String>? readAccess;

  ChatInteractionsModel({this.documentID, this.authorId, this.appId, this.details, this.readAccess, })  {
    assert(documentID != null);
  }

  ChatInteractionsModel copyWith({String? documentID, String? authorId, String? appId, String? details, List<String>? readAccess, }) {
    return ChatInteractionsModel(documentID: documentID ?? this.documentID, authorId: authorId ?? this.authorId, appId: appId ?? this.appId, details: details ?? this.details, readAccess: readAccess ?? this.readAccess, );
  }

  @override
  int get hashCode => documentID.hashCode ^ authorId.hashCode ^ appId.hashCode ^ details.hashCode ^ readAccess.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatInteractionsModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          authorId == other.authorId &&
          appId == other.appId &&
          details == other.details &&
          ListEquality().equals(readAccess, other.readAccess);

  @override
  String toString() {
    String readAccessCsv = (readAccess == null) ? '' : readAccess!.join(', ');

    return 'ChatInteractionsModel{documentID: $documentID, authorId: $authorId, appId: $appId, details: $details, readAccess: String[] { $readAccessCsv }}';
  }

  ChatInteractionsEntity toEntity({String? appId}) {
    return ChatInteractionsEntity(
          authorId: (authorId != null) ? authorId : null, 
          appId: (appId != null) ? appId : null, 
          details: (details != null) ? details : null, 
          readAccess: (readAccess != null) ? readAccess : null, 
    );
  }

  static ChatInteractionsModel? fromEntity(String documentID, ChatInteractionsEntity? entity) {
    if (entity == null) return null;
    var counter = 0;
    return ChatInteractionsModel(
          documentID: documentID, 
          authorId: entity.authorId, 
          appId: entity.appId, 
          details: entity.details, 
          readAccess: entity.readAccess, 
    );
  }

  static Future<ChatInteractionsModel?> fromEntityPlus(String documentID, ChatInteractionsEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    var counter = 0;
    return ChatInteractionsModel(
          documentID: documentID, 
          authorId: entity.authorId, 
          appId: entity.appId, 
          details: entity.details, 
          readAccess: entity.readAccess, 
    );
  }

}

