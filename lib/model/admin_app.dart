/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/admin_app.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_core/tools/admin_app_base.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_core/tools/common_tools.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/menu_def_model.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/menu_item_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';

import 'package:eliud_core/model/repository_export.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/repository_export.dart';
import 'package:eliud_core/model/model_export.dart';
import '../tools/bespoke_models.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';
import 'package:eliud_core/model/entity_export.dart';
import '../tools/bespoke_entities.dart';
import 'package:eliud_pkg_chat/model/entity_export.dart';

class AdminApp extends AdminAppInstallerBase {
  final String appId;
  final DrawerModel _drawer;
  final DrawerModel _endDrawer;
  final AppBarModel _appBar;
  final HomeMenuModel _homeMenu;
  final RgbModel menuItemColor;
  final RgbModel selectedMenuItemColor;
  final RgbModel backgroundColor;
  
  AdminApp(this.appId, this._drawer, this._endDrawer, this._appBar, this._homeMenu, this.menuItemColor, this.selectedMenuItemColor, this.backgroundColor);


  PageModel _chatsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-chats", componentName: "eliud_pkg_chat_internalWidgets", componentId: "chats"));
    PageModel page = PageModel(
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.OwnerPrivilegeRequired,
          packageCondition: null,
          conditionOverride: null,
        ),
        appId: appId,
        documentID: "eliud_pkg_chat_chats_page",
        title: "Chats",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _chatDashboardsPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-chatDashboards", componentName: "eliud_pkg_chat_internalWidgets", componentId: "chatDashboards"));
    PageModel page = PageModel(
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.OwnerPrivilegeRequired,
          packageCondition: null,
          conditionOverride: null,
        ),
        appId: appId,
        documentID: "eliud_pkg_chat_chatdashboards_page",
        title: "ChatDashboards",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  PageModel _chatInteractionssPages() {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
      documentID: "internalWidget-chatInteractionss", componentName: "eliud_pkg_chat_internalWidgets", componentId: "chatInteractionss"));
    PageModel page = PageModel(
        conditions: ConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.OwnerPrivilegeRequired,
          packageCondition: null,
          conditionOverride: null,
        ),
        appId: appId,
        documentID: "eliud_pkg_chat_chatinteractionss_page",
        title: "ChatInteractionss",
        drawer: _drawer,
        endDrawer: _endDrawer,
        appBar: _appBar,
        homeMenu: _homeMenu,
        bodyComponents: components,
        layout: PageLayout.OnlyTheFirstComponent
    );
    return page;
  }


  Future<void> _setupAdminPages() {

    return pageRepository(appId: appId)!.add(_chatsPages())

        .then((_) => pageRepository(appId: appId)!.add(_chatDashboardsPages()))

        .then((_) => pageRepository(appId: appId)!.add(_chatInteractionssPages()))

    ;
  }

  @override
  Future<void> run() async {
    return _setupAdminPages();
  }


}

class AdminMenu extends AdminAppMenuInstallerBase {

  Future<MenuDefModel> menu(String appId) async {
    var menuItems = <MenuItemModel>[];

    menuItems.add(
      MenuItemModel(
        documentID: "Chats",
        text: "Chats",
        description: "Chats",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(appId, pageID: "eliud_pkg_chat_chats_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "ChatDashboards",
        text: "ChatDashboards",
        description: "ChatDashboards",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(appId, pageID: "eliud_pkg_chat_chatdashboards_page"))
    );


    menuItems.add(
      MenuItemModel(
        documentID: "ChatInteractionss",
        text: "ChatInteractionss",
        description: "ChatInteractionss",
        icon: IconModel(codePoint: 0xe88a, fontFamily: "MaterialIcons"),
        action: GotoPage(appId, pageID: "eliud_pkg_chat_chatinteractionss_page"))
    );


    MenuDefModel menu = MenuDefModel(
      admin: true,
      documentID: "eliud_pkg_chat_admin_menu",
      appId: appId,
      name: "eliud_pkg_chat",
      menuItems: menuItems
    );
    await menuDefRepository(appId: appId)!.add(menu);
    return menu;
  }
}

class AdminAppWiper extends AdminAppWiperBase {

  @override
  Future<void> deleteAll(String appId) async {
    ;
  }


}

