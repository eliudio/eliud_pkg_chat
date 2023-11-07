import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/access_event.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core_package.dart';
import 'package:eliud_core/eliud.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/package/package.dart';
import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_pkg_chat/wizards/chat_page_wizard.dart';
import 'package:eliud_pkg_follow/follow_package.dart';
import 'package:eliud_pkg_medium/medium_package.dart';
import 'model/abstract_repository_singleton.dart';
import 'model/component_registry.dart';
import 'model/member_has_chat_model.dart';
import 'model/repository_singleton.dart';

import 'package:eliud_pkg_chat/chat_package_stub.dart'
    if (dart.library.io) 'chat_mobile_package.dart'
    if (dart.library.html) 'chat_web_package.dart';

import 'dart:async';

abstract class ChatPackage extends Package {
  static const String conditionMemberHasUnreadChat =
      'There are some unread messages';
  static const String conditionMemberAllHaveBeenRead =
      'All messages have been read';
  final Map<String, bool?> stateConditionMemberHasUnreadChat = {};
  final Map<String, StreamSubscription<MemberHasChatModel?>> subscription = {};

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
          stateConditionMemberHasUnreadChat[app.documentID] = hasUnread;
          // the first time we get this trigger, it's upon entry of the getAndSubscribe. Now we simply return the value
          c.complete([
            PackageConditionDetails(
                packageName: packageName,
                conditionName: conditionMemberHasUnreadChat,
                value: hasUnread),
            PackageConditionDetails(
                packageName: packageName,
                conditionName: conditionMemberAllHaveBeenRead,
                value: !hasUnread),
          ]);
        } else {
          // subsequent calls we get this trigger, it's when the date has changed. Now add the event to the bloc
          if (hasUnread != stateConditionMemberHasUnreadChat[appId]) {
            stateConditionMemberHasUnreadChat[app.documentID] = hasUnread;
            accessBloc.add(UpdatePackageConditionEvent(
                app, this, conditionMemberHasUnreadChat, hasUnread));
            accessBloc.add(UpdatePackageConditionEvent(
                app, this, conditionMemberAllHaveBeenRead, !hasUnread));
          }
        }
      });
      return c.future;
    } else {
      stateConditionMemberHasUnreadChat[app.documentID] = false;
      return Future.value([
        PackageConditionDetails(
            packageName: packageName,
            conditionName: conditionMemberHasUnreadChat,
            value: false),
        PackageConditionDetails(
            packageName: packageName,
            conditionName: conditionMemberAllHaveBeenRead,
            value: false),
      ]);
    }
  }

  @override
  List<String> retrieveAllPackageConditions() {
    return [conditionMemberHasUnreadChat, conditionMemberAllHaveBeenRead];
  }

  @override
  void init() {
    ComponentRegistry().init();

    // wizards
    NewAppWizardRegistry.registry().register(ChatPageWizard());

    AbstractRepositorySingleton.singleton = RepositorySingleton();
  }

  /*
   * Register depending packages
   */
  @override
  void registerDependencies(Eliud eliud) {
    eliud.registerPackage(CorePackage.instance());
    eliud.registerPackage(FollowPackage.instance());
    eliud.registerPackage(MediumPackage.instance());
  }

  @override
  List<MemberCollectionInfo> getMemberCollectionInfo() =>
      AbstractRepositorySingleton.collections;

  static ChatPackage instance() => getChatPackage();
}
