import 'package:eliud_core/core/wizards/registry/new_app_wizard_info_with_action_specification.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/public_medium_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:flutter/material.dart';

import 'builders/page/chat_page_builder.dart';

class ChatPageWizard extends NewAppWizardInfoWithActionSpecification {
  static String FEED_PAGE_ID = 'feed';

  ChatPageWizard() : super('chat', 'Chat', 'Generate a default Chat Page');

  @override
  String getPackageName() => "eliud_pkg_chat";

  @override
  NewAppWizardParameters newAppWizardParameters() =>
      ActionSpecificationParametersBase(
        requiresAccessToLocalFileSystem: false,
        availableInLeftDrawer: false,
        availableInRightDrawer: false,
        availableInAppBar: true,
        availableInHomeMenu: false,
        available: false,
      );

  @override
  List<MenuItemModel> getThoseMenuItems(String uniqueId, AppModel app) => [
        MenuItemModel(
            documentID: newRandomKey(),
            text: 'Chat',
            description: 'Some unread messages available',
            icon: IconModel(
                codePoint: Icons.chat_bubble_rounded.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: ChatPageBuilder.unReadAction(app, uniqueId)),
        MenuItemModel(
            documentID: newRandomKey(),
            text: 'Chat',
            description: 'Open chat',
            icon: IconModel(
                codePoint: Icons.chat_bubble_outline_rounded.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: ChatPageBuilder.readAction(app, uniqueId)),
      ];

  @override
  List<NewAppTask>? getCreateTasks(
    String uniqueId,
    AppModel app,
    NewAppWizardParameters parameters,
    MemberModel member,
    HomeMenuProvider homeMenuProvider,
    AppBarProvider appBarProvider,
    DrawerProvider leftDrawerProvider,
    DrawerProvider rightDrawerProvider,
    PageProvider pageProvider,
  ) {
    if (parameters is ActionSpecificationParametersBase) {
      var chatPageSpecifications = parameters.actionSpecifications;
      if (chatPageSpecifications.shouldCreatePageDialogOrWorkflow()) {
        List<NewAppTask> tasks = [];
        var memberId = member.documentID!;
        tasks.add(() async {
          await ChatPageBuilder(
                  uniqueId,
                  FEED_PAGE_ID,
                  app,
                  memberId,
                  homeMenuProvider(),
                  appBarProvider(),
                  leftDrawerProvider(),
                  rightDrawerProvider(),
                  pageProvider,
                  )
              .create();
        });
        return tasks;
      }
    } else {
      throw Exception(
          'Unexpected class for parameters: ' + parameters.toString());
    }
  }

  @override
  AppModel updateApp(
    String uniqueId,
    NewAppWizardParameters parameters,
    AppModel adjustMe,
  ) =>
      adjustMe;

  @override
  String? getPageID(String uniqueId, NewAppWizardParameters parameters,
          String pageType) =>
      null;

  @override
  ActionModel? getAction(
    String uniqueId,
    NewAppWizardParameters parameters,
    AppModel app,
    String actionType,
  ) =>
      null;

  @override
  PublicMediumModel? getPublicMediumModel(String uniqueId, NewAppWizardParameters parameters, String pageType) => null;
}
