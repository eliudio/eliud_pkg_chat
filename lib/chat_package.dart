import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core/model/access_model.dart';
import 'model/abstract_repository_singleton.dart';
import 'model/component_registry.dart';
import 'model/member_has_chat_model.dart';
import 'model/repository_singleton.dart';

import 'dart:async';

abstract class ChatPackage extends Package {
  static final String CONDITION_MEMBER_HAS_UNREAD_CHAT = 'There are some unread messages';
  static final String CONDITION_MEMBER_ALL_HAVE_BEEN_READ =
      'All messages have been read';
  bool? state_CONDITION_MEMBER_HAS_UNREAD_CHAT = null;
  late StreamSubscription<MemberHasChatModel?> subscription;

  ChatPackage() : super('eliud_pkg_chat');

  @override
  Future<bool?> isConditionOk(
      String pluginCondition,
      AppModel app,
      MemberModel? member,
      bool isOwner,
      bool? isBlocked,
      PrivilegeLevel? privilegeLevel) async {
    if (pluginCondition == CONDITION_MEMBER_HAS_UNREAD_CHAT) {
      if (state_CONDITION_MEMBER_HAS_UNREAD_CHAT == null) return false;
      return state_CONDITION_MEMBER_HAS_UNREAD_CHAT;
    }
    if (pluginCondition == CONDITION_MEMBER_ALL_HAVE_BEEN_READ) {
      if (state_CONDITION_MEMBER_HAS_UNREAD_CHAT == null) return true;
      return !state_CONDITION_MEMBER_HAS_UNREAD_CHAT!;
    }
    return null;
  }

  @override
  List<String> retrieveAllPackageConditions() {
    return [
      CONDITION_MEMBER_HAS_UNREAD_CHAT,
      CONDITION_MEMBER_ALL_HAVE_BEEN_READ
    ];
  }

  @override
  void init() {
    ComponentRegistry().init();

    AbstractRepositorySingleton.singleton = RepositorySingleton();
  }

  @override
  void resubscribe(AppModel app, MemberModel? currentMember) {
    String? appId = app.documentID;
    if (currentMember != null) {
      subscription = memberHasChatRepository(
        appId: appId,
      )!
          .listenTo(currentMember.documentID!, (value) {
        if (value != null) {
          _setState(value.hasUnread!, currentMember: currentMember);
        }
      });
    } else {
      _setState(false);
    }
  }

  void _setState(bool hasUnreadChat, {MemberModel? currentMember}) {
    if (hasUnreadChat != state_CONDITION_MEMBER_HAS_UNREAD_CHAT) {
      state_CONDITION_MEMBER_HAS_UNREAD_CHAT = hasUnreadChat;
      //accessBloc!.add(Package...(currentMember));
    }
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() => AbstractRepositorySingleton.collections;
}
