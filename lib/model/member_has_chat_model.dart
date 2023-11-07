/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_model.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/base/model_base.dart';

import 'package:eliud_pkg_chat/model/entity_export.dart';

import 'package:eliud_pkg_chat/model/member_has_chat_entity.dart';

class MemberHasChatModel implements ModelBase, WithAppId {
  static const String packageName = 'eliud_pkg_chat';
  static const String id = 'memberHasChats';

  @override
  String documentID;
  String memberId;

  // This is the identifier of the app to which this chat belongs
  @override
  String appId;
  bool? hasUnread;

  MemberHasChatModel({
    required this.documentID,
    required this.memberId,
    required this.appId,
    this.hasUnread,
  });

  @override
  MemberHasChatModel copyWith({
    String? documentID,
    String? memberId,
    String? appId,
    bool? hasUnread,
  }) {
    return MemberHasChatModel(
      documentID: documentID ?? this.documentID,
      memberId: memberId ?? this.memberId,
      appId: appId ?? this.appId,
      hasUnread: hasUnread ?? this.hasUnread,
    );
  }

  @override
  int get hashCode =>
      documentID.hashCode ^
      memberId.hashCode ^
      appId.hashCode ^
      hasUnread.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberHasChatModel &&
          runtimeType == other.runtimeType &&
          documentID == other.documentID &&
          memberId == other.memberId &&
          appId == other.appId &&
          hasUnread == other.hasUnread;

  @override
  String toString() {
    return 'MemberHasChatModel{documentID: $documentID, memberId: $memberId, appId: $appId, hasUnread: $hasUnread}';
  }

  @override
  Future<List<ModelReference>> collectReferences({String? appId}) async {
    List<ModelReference> referencesCollector = [];
    return referencesCollector;
  }

  @override
  MemberHasChatEntity toEntity({String? appId}) {
    return MemberHasChatEntity(
      memberId: memberId,
      appId: appId,
      hasUnread: (hasUnread != null) ? hasUnread : null,
    );
  }

  static Future<MemberHasChatModel?> fromEntity(
      String documentID, MemberHasChatEntity? entity) async {
    if (entity == null) return null;
    return MemberHasChatModel(
      documentID: documentID,
      memberId: entity.memberId ?? '',
      appId: entity.appId ?? '',
      hasUnread: entity.hasUnread,
    );
  }

  static Future<MemberHasChatModel?> fromEntityPlus(
      String documentID, MemberHasChatEntity? entity,
      {String? appId}) async {
    if (entity == null) return null;

    return MemberHasChatModel(
      documentID: documentID,
      memberId: entity.memberId ?? '',
      appId: entity.appId ?? '',
      hasUnread: entity.hasUnread,
    );
  }
}
