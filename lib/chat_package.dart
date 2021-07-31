import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core/package/package_with_subscription.dart';
import 'package:eliud_core/model/access_model.dart';
import 'model/abstract_repository_singleton.dart';
import 'model/component_registry.dart';
import 'model/repository_singleton.dart';

import 'dart:async';


abstract class ChatPackage extends PackageWithSubscription {
  static final String CONDITION_MEMBER_HAS_UNREAD_CHAT = 'Unread Chats';
  static final String CONDITION_MEMBER_DOES_NOT_HAVE_UNREAD_CHAT = 'No unread Chats';
  bool? state_CONDITION_MEMBER_HAS_UNREAD_CHAT = null;

  @override
  Future<bool?> isConditionOk(String pluginCondition, AppModel app, MemberModel? member, bool isOwner, bool? isBlocked, PrivilegeLevel? privilegeLevel) async {
    if (pluginCondition == CONDITION_MEMBER_HAS_UNREAD_CHAT) {
      if (state_CONDITION_MEMBER_HAS_UNREAD_CHAT == null) return false;
      return state_CONDITION_MEMBER_HAS_UNREAD_CHAT;
    }
    if (pluginCondition == CONDITION_MEMBER_DOES_NOT_HAVE_UNREAD_CHAT) {
      if (state_CONDITION_MEMBER_HAS_UNREAD_CHAT == null) return true;
      return !state_CONDITION_MEMBER_HAS_UNREAD_CHAT!;
    }
    return null;
  }

  @override
  List<String> retrieveAllPackageConditions() {
    return [ CONDITION_MEMBER_HAS_UNREAD_CHAT, CONDITION_MEMBER_DOES_NOT_HAVE_UNREAD_CHAT ];
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() => [];

  @override
  void init() {
    ComponentRegistry().init();

    AbstractRepositorySingleton.singleton = RepositorySingleton();
  }

  @override
  void resubscribe(AppModel app, MemberModel? currentMember) {
    String? appId = app.documentID;
    if (currentMember != null) {
      subscription = memberHasChatRepository(appId: appId, )!.listenTo(currentMember.documentID!, (value) =>
        _setState(value!.hasUnread!, currentMember: currentMember)
      );
    } else {
      _setState(false);
    }
  }

  @override
  void unsubscribe() {
    super.unsubscribe();
    _setState(false);
  }

  void _setState(bool newState, {MemberModel? currentMember}) {
    if (newState != state_CONDITION_MEMBER_HAS_UNREAD_CHAT) {
      state_CONDITION_MEMBER_HAS_UNREAD_CHAT = newState;
      accessBloc!.add(MemberUpdated(currentMember));
    }
  }
}


