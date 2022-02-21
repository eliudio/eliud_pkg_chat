import 'package:eliud_core/core/wizards/registry/new_app_wizard_info_with_action_specification.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/model/app_model.dart';
import 'package:eliud_core/model/display_conditions_model.dart';
import 'package:eliud_core/model/icon_model.dart';
import 'package:eliud_core/model/member_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:flutter/material.dart';

import 'builders/dialog/chat_dialog_builder.dart';
import 'builders/page/chat_page_builder.dart';

class ChatPageWizard extends NewAppWizardInfoWithActionSpecification {
  static String FEED_PAGE_ID = 'feed';

  ChatPageWizard() : super('chat', 'Chat', 'Generate Chat Page');

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
  List<MenuItemModel> getThoseMenuItems(AppModel app) => [
        MenuItemModel(
            documentID: newRandomKey(),
            text: 'Chat',
            description: 'Some unread messages available',
            icon: IconModel(
                codePoint: Icons.chat_bubble_rounded.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: ChatPageBuilder.unReadAction(app)),
        MenuItemModel(
            documentID: newRandomKey(),
            text: 'Chat',
            description: 'Open chat',
            icon: IconModel(
                codePoint: Icons.chat_bubble_outline_rounded.codePoint,
                fontFamily: Icons.notifications.fontFamily),
            action: ChatPageBuilder.readAction(app)),
      ];

  @override
  List<NewAppTask>? getCreateTasks(
    AppModel app,
    NewAppWizardParameters parameters,
    MemberModel member,
    HomeMenuProvider homeMenuProvider,
    AppBarProvider appBarProvider,
    DrawerProvider leftDrawerProvider,
    DrawerProvider rightDrawerProvider,
  ) {
    if (parameters is ActionSpecificationParametersBase) {
      var chatPageSpecifications = parameters.actionSpecifications;
      if (chatPageSpecifications.shouldCreatePageDialogOrWorkflow()) {
        List<NewAppTask> tasks = [];
        var memberId = member.documentID!;
        tasks.add(() async {
          await ChatPageBuilder(FEED_PAGE_ID,
              app,
              memberId,
              homeMenuProvider(),
              appBarProvider(),
              leftDrawerProvider(),
              rightDrawerProvider()
          ).create();
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
    NewAppWizardParameters parameters,
    AppModel adjustMe,
  ) =>
      adjustMe;

  @override
  String? getPageID(String pageType) => null;
  
  @override
  ActionModel? getAction(AppModel app, String actionType, ) => null;
}
