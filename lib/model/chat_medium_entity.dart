/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_core/core/base/entity_base.dart';

class ChatMediumEntity implements EntityBase {
  final String? memberMediumId;

  ChatMediumEntity({
    this.memberMediumId,
  });

  ChatMediumEntity copyWith({
    String? documentID,
    String? memberMediumId,
  }) {
    return ChatMediumEntity(
      memberMediumId: memberMediumId ?? this.memberMediumId,
    );
  }

  List<Object?> get props => [
        memberMediumId,
      ];

  @override
  String toString() {
    return 'ChatMediumEntity{memberMediumId: $memberMediumId}';
  }

  static ChatMediumEntity? fromMap(Object? o,
      {Map<String, String>? newDocumentIds}) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    var memberMediumIdNewDocmentId = map['memberMediumId'];
    if ((newDocumentIds != null) && (memberMediumIdNewDocmentId != null)) {
      var memberMediumIdOldDocmentId = memberMediumIdNewDocmentId;
      memberMediumIdNewDocmentId = newRandomKey();
      newDocumentIds[memberMediumIdOldDocmentId] = memberMediumIdNewDocmentId;
    }
    return ChatMediumEntity(
      memberMediumId: memberMediumIdNewDocmentId,
    );
  }

  @override
  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (memberMediumId != null) {
      theDocument["memberMediumId"] = memberMediumId;
    } else {
      theDocument["memberMediumId"] = null;
    }
    return theDocument;
  }

  @override
  ChatMediumEntity switchAppId({required String newAppId}) {
    var newEntity = copyWith();
    return newEntity;
  }

  static ChatMediumEntity? fromJsonString(String json,
      {Map<String, String>? newDocumentIds}) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap, newDocumentIds: newDocumentIds);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

  @override
  Future<Map<String, Object?>> enrichedDocument(
      Map<String, Object?> theDocument) async {
    return theDocument;
  }
}
