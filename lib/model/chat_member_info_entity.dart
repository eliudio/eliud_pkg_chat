/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_entity.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:collection';
import 'dart:convert';
import 'package:eliud_core/tools/common_tools.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class ChatMemberInfoEntity {
  final String? memberId;
  final String? roomId;
  final Object? timestamp;

  ChatMemberInfoEntity({this.memberId, this.roomId, this.timestamp, });

  ChatMemberInfoEntity copyWith({Object? timestamp, }) {
    return ChatMemberInfoEntity(memberId: memberId, roomId: roomId, timestamp : timestamp, );
  }
  List<Object?> get props => [memberId, roomId, timestamp, ];

  @override
  String toString() {
    return 'ChatMemberInfoEntity{memberId: $memberId, roomId: $roomId, timestamp: $timestamp}';
  }

  static ChatMemberInfoEntity? fromMap(Object? o) {
    if (o == null) return null;
    var map = o as Map<String, dynamic>;

    return ChatMemberInfoEntity(
      memberId: map['memberId'], 
      roomId: map['roomId'], 
      timestamp: map['timestamp']
    );
  }

  Map<String, Object?> toDocument() {
    Map<String, Object?> theDocument = HashMap();
    if (memberId != null) theDocument["memberId"] = memberId;
      else theDocument["memberId"] = null;
    if (roomId != null) theDocument["roomId"] = roomId;
      else theDocument["roomId"] = null;
    theDocument["timestamp"] = timestamp;
    return theDocument;
  }

  static ChatMemberInfoEntity? fromJsonString(String json) {
    Map<String, dynamic>? generationSpecificationMap = jsonDecode(json);
    return fromMap(generationSpecificationMap);
  }

  String toJsonString() {
    return jsonEncode(toDocument());
  }

}

