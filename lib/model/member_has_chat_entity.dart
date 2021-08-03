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
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class MemberHasChatEntity {
  final String? memberId;
  final String? appId;
  final bool? hasUnread;

  MemberHasChatEntity({this.memberId, this.appId, this.hasUnread, });


  List<Object?> get props => [memberId, appId, hasUnread, ];

  @override
  String toString() {
    return 'MemberHasChatEntity{memberId: $memberId, appId: $appId, hasUnread: $hasUnread}';
  }

  static MemberHasChatEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return MemberHasChatEntity(
      memberId: map['memberId'], 
      appId: map['appId'], 
      hasUnread: map['hasUnread'], 
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (memberId != null) theDocument["memberId"] = memberId;
      else theDocument["memberId"] = null;
    if (appId != null) theDocument["appId"] = appId;
      else theDocument["appId"] = null;
    if (hasUnread != null) theDocument["hasUnread"] = hasUnread;
      else theDocument["hasUnread"] = null;
    return theDocument;
  }

  static MemberHasChatEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}
