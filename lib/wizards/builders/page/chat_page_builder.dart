import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/core/wizards/tools/document_identifier.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_chat/chat_package.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

class ChatPageBuilder extends PageBuilder {
  ChatPageBuilder(
    super.uniqueId,
    super.pageId,
    super.app,
    super.memberId,
    super.theHomeMenu,
    super.theAppBar,
    super.leftDrawer,
    super.rightDrawer,
  );

  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String identifierRead = "chat_page_read";
  static String identifierUnread = "chat_page_unread";

  static GotoPage unReadAction(AppModel app, String uniqueId) => GotoPage(app,
      pageID:
          constructDocumentId(uniqueId: uniqueId, documentId: identifierUnread),
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
          packageCondition: ChatPackage.conditionMemberHasUnreadChat));

  static GotoPage readAction(AppModel app, String uniqueId) => GotoPage(app,
      pageID:
          constructDocumentId(uniqueId: uniqueId, documentId: identifierRead),
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.noPrivilegeRequired,
          packageCondition: ChatPackage.conditionMemberAllHaveBeenRead));

  static String chatId = "chat";

  Future<PageModel> _setupPage(String identifier) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .pageRepository(app.documentID)!
        .add(_page(identifier));
  }

  PageModel _page(String identifier) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatDashboardComponent.componentName,
        componentId:
            constructDocumentId(uniqueId: uniqueId, documentId: chatId)));

    return PageModel(
        documentID:
            constructDocumentId(uniqueId: uniqueId, documentId: identifier),
        appId: app.documentID,
        title: "Chat",
        description: "Chat",
        drawer: leftDrawer,
        endDrawer: rightDrawer,
        homeMenu: theHomeMenu,
        appBar: theAppBar,
        layout: PageLayout.listView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  ChatDashboardModel _chatModel() {
    return ChatDashboardModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: chatId),
      appId: app.documentID,
      description: "Chat",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.noPrivilegeRequiredSimple),
    );
  }

  Future<ChatDashboardModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatDashboardRepository(app.documentID)!
        .add(_chatModel());
  }

  Future<void> create() async {
    await _setupChat();
    await _setupPage(identifierRead);
    await _setupPage(identifierUnread);
  }
}
