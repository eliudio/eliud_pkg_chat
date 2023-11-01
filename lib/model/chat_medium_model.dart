/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/base/model_base.dart';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';


import 'package:eliud_pkg_chat/model/chat_medium_entity.dart';




class ChatMediumModel implements ModelBase {
  static const String packageName = 'eliud_pkg_chat';
  static const String id = 'chatMediums';

  @override
  String documentID;
  MemberMediumModel? memberMedium;

  ChatMediumModel({required this.documentID, this.memberMedium, });

  @override
  ChatMediumModel copyWith({String? documentID, MemberMediumModel? memberMedium, }) {
    return ChatMediumModel(documentID: documentID ?? this.documentID, memberMedium: memberMedium ?? this.memberMedium, );
  }

  @override
  int get hashCode => documentID.hashCode ^ memberMedium.hashCode;

  @override
  bool operator ==(Object other) =>
          identical(this, other) ||
          other is ChatMediumModel &&
          runtimeType == other.runtimeType && 
          documentID == other.documentID &&
          memberMedium == other.memberMedium;

  @override
  String toString() {
    return 'ChatMediumModel{documentID: $documentID, memberMedium: $memberMedium}';
  }

  @override
  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    if (memberMedium != null) {
      referencesCollector.add(ModelReference(MemberMediumModel.packageName, MemberMediumModel.id, memberMedium!));
    }
    if (memberMedium != null) referencesCollector.addAll(await memberMedium!.collectReferences(appId: appId));
    return referencesCollector;
  }

  @override
  ChatMediumEntity toEntity({String? appId}) {
    return ChatMediumEntity(
          memberMediumId: (memberMedium != null) ? memberMedium!.documentID : null, 
    );
  }

  static Future<ChatMediumModel?> fromEntity(String documentID, ChatMediumEntity? entity) async {
    if (entity == null) return null;
    var counter = 0;
    return ChatMediumModel(
          documentID: documentID, 
    );
  }

  static Future<ChatMediumModel?> fromEntityPlus(String documentID, ChatMediumEntity? entity, { String? appId}) async {
    if (entity == null) return null;

    MemberMediumModel? memberMediumHolder;
    if (entity.memberMediumId != null) {
      try {
          memberMediumHolder = await memberMediumRepository(appId: appId)!.get(entity.memberMediumId);
      } on Exception catch(e) {
        print('Error whilst trying to initialise memberMedium');
        print('Error whilst retrieving memberMedium with id ${entity.memberMediumId}');
        print('Exception: $e');
      }
    }

    var counter = 0;
    return ChatMediumModel(
          documentID: documentID, 
          memberMedium: memberMediumHolder, 
    );
  }

}

