import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/model/body_component_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_chat/chat_package.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

class ChatPageBuilder extends PageBuilder {
  ChatPageBuilder(String pageId,
      AppModel app,
      String memberId,
      HomeMenuModel theHomeMenu,
      AppBarModel theAppBar,
      DrawerModel leftDrawer,
      DrawerModel rightDrawer,
      PageProvider pageProvider,
      ActionProvider actionProvider,
      )
      : super(pageId, app, memberId, theHomeMenu, theAppBar, leftDrawer,
      rightDrawer, pageProvider, actionProvider);


  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String IDENTIFIER_READ = "chat_page_read";
  static String IDENTIFIER_UNREAD = "chat_page_unread";

  static GotoPage unReadAction(AppModel app) => GotoPage(app, pageID: IDENTIFIER_UNREAD,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_HAS_UNREAD_CHAT));

  static GotoPage readAction(AppModel app) => GotoPage(app, pageID: IDENTIFIER_READ,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_ALL_HAVE_BEEN_READ));

  static String CHAT_ID = "chat";

  Future<PageModel> _setupPage(String identifier) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(app.documentID!)!
        .add(_page(identifier));
  }

  PageModel _page(String identifier) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatDashboardComponent.componentName,
        componentId: CHAT_ID));

    return PageModel(
        documentID: identifier,
        appId: app.documentID!,
        title: "Chat",
        drawer: leftDrawer,
        endDrawer: rightDrawer,
        homeMenu: theHomeMenu,
        appBar: theAppBar,
        layout: PageLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  ChatDashboardModel _chatModel() {
    return ChatDashboardModel(
      documentID: CHAT_ID,
      appId: app.documentID!,
      description: "Chat",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<ChatDashboardModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatDashboardRepository(app.documentID!)!
        .add(_chatModel());
  }

  Future<void> create() async {
    await _setupChat();
    await _setupPage(IDENTIFIER_READ);
    await _setupPage(IDENTIFIER_UNREAD);
  }
}
