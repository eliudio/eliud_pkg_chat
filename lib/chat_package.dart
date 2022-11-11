import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/access_event.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_pkg_chat/wizards/chat_page_wizard.dart';
import 'model/abstract_repository_singleton.dart';
import 'model/component_registry.dart';
import 'model/member_has_chat_model.dart';
import 'model/repository_singleton.dart';

import 'package:eliud_pkg_chat/chat_package_stub.dart'
if (dart.library.io) 'chat_mobile_package.dart'
if (dart.library.html) 'chat_web_package.dart';

import 'dart:async';

abstract class ChatPackage extends Package {
  static const String CONDITION_MEMBER_HAS_UNREAD_CHAT =
      'There are some unread messages';
  static const String CONDITION_MEMBER_ALL_HAVE_BEEN_READ =
      'All messages have been read';
  Map<String, bool?> state_CONDITION_MEMBER_HAS_UNREAD_CHAT = {};
  Map<String, StreamSubscription<MemberHasChatModel?>> subscription = {};

  ChatPackage() : super('eliud_pkg_chat');

  @override
  Future<List<PackageConditionDetails>>? getAndSubscribe(
      AccessBloc accessBloc,
      AppModel app,
      MemberModel? member,
      bool isOwner,
      bool? isBlocked,
      PrivilegeLevel? privilegeLevel) {
    String appId = app.documentID;
    subscription[appId]?.cancel();
    if (member != null) {
      final c = Completer<List<PackageConditionDetails>>();
      subscription[appId] = memberHasChatRepository(
        appId: appId,
      )!
          .listenTo(member.documentID, (value) {
        var hasUnread = false;
        if (value != null) {
          hasUnread = value.hasUnread!;
        }
        if (!c.isCompleted) {
          state_CONDITION_MEMBER_HAS_UNREAD_CHAT[app.documentID] = hasUnread;
          // the first time we get this trigger, it's upon entry of the getAndSubscribe. Now we simply return the value
          c.complete([
            PackageConditionDetails(
                packageName: packageName,
                conditionName: CONDITION_MEMBER_HAS_UNREAD_CHAT,
                value: hasUnread),
            PackageConditionDetails(
                packageName: packageName,
                conditionName: CONDITION_MEMBER_ALL_HAVE_BEEN_READ,
                value: !hasUnread),
          ]);
        } else {
          // subsequent calls we get this trigger, it's when the date has changed. Now add the event to the bloc
          if (hasUnread != state_CONDITION_MEMBER_HAS_UNREAD_CHAT[appId]) {
            state_CONDITION_MEMBER_HAS_UNREAD_CHAT[app.documentID] = hasUnread;
            accessBloc.add(UpdatePackageConditionEvent(
                app, this, CONDITION_MEMBER_HAS_UNREAD_CHAT, hasUnread));
            accessBloc.add(UpdatePackageConditionEvent(
                app, this, CONDITION_MEMBER_ALL_HAVE_BEEN_READ, !hasUnread));
          }
        }
      });
      return c.future;
    } else {
      state_CONDITION_MEMBER_HAS_UNREAD_CHAT[app.documentID] = false;
      return Future.value([
        PackageConditionDetails(
            packageName: packageName,
            conditionName: CONDITION_MEMBER_HAS_UNREAD_CHAT,
            value: false),
        PackageConditionDetails(
            packageName: packageName,
            conditionName: CONDITION_MEMBER_ALL_HAVE_BEEN_READ,
            value: false),
      ]);
    }
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

    // wizards
    NewAppWizardRegistry.registry().register(ChatPageWizard());

    AbstractRepositorySingleton.singleton = RepositorySingleton();
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() =>
      AbstractRepositorySingleton.collections;

  static ChatPackage instance() => getChatPackage();
}
