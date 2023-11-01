/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/core/base/entity_base.dart';

class MemberHasChatEntity implements EntityBase {
  final String? memberId;
  final String? appId;
  final bool? hasUnread;

  MemberHasChatEntity({required this.memberId, required this.appId, this.hasUnread, });

  MemberHasChatEntity copyWith({String? documentID, String? memberId, String? appId, bool? hasUnread, }) {
    return MemberHasChatEntity(memberId : memberId ?? this.memberId, appId : appId ?? this.appId, hasUnread : hasUnread ?? this.hasUnread, );
  }
  List<Object?> get props => [memberId, appId, hasUnread, ];

  @override
  String toString() {
    return 'MemberHasChatEntity{memberId: $memberId, appId: $appId, hasUnread: $hasUnread}';
  }

  static MemberHasChatEntity? fromMap(Object? o, {Map<String, String>? newDocumentIds}) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return MemberHasChatEntity(
      memberId: map['memberId'], 
      appId: map['appId'], 
      hasUnread: map['hasUnread'], 
    );
  }

  @override
  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (memberId != null) {
      theDocument["memberId"] = memberId;
    } else {
      theDocument["memberId"] = null;
    }
    if (appId != null) {
      theDocument["appId"] = appId;
    } else {
      theDocument["appId"] = null;
    }
    if (hasUnread != null) {
      theDocument["hasUnread"] = hasUnread;
    } else {
      theDocument["hasUnread"] = null;
    }
    return theDocument;
  }

  @override
  MemberHasChatEntity switchAppId({required String newAppId}) {
    var newEntity = copyWith(appId: newAppId);
    return newEntity;
  }

  static MemberHasChatEntity? fromJsonString(String json, {Map<String, String>? newDocumentIds}) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap, newDocumentIds: newDocumentIds);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

  @override
  Future<Map<String, Object?>> enrichedDocument(Map<String, Object?> theDocument) async {
    return theDocument;
  }

}

