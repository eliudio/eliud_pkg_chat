import 'package:eliud_core/core/wizards/builders/dialog_builder.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart'
    as corerepo;
import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/tools/action/action_model.dart';
import 'package:eliud_pkg_chat/chat_package.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';
import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';

class ChatDialogBuilder extends DialogBuilder {
  ChatDialogBuilder(String uniqueId, AppModel app, ) : super(uniqueId, app, 'NA');

  // Security is setup to indicate if a page or dialog is accessible
  // For this reason we need 2 dialogs, one for unread and one for read chats
  static String IDENTIFIER_READ = "chat_dialog_read";
  static String IDENTIFIER_UNREAD = "chat_dialog_unread";

  static OpenDialog unReadAction(AppModel app) => OpenDialog(app,
      dialogID: IDENTIFIER_UNREAD,
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_HAS_UNREAD_CHAT));

  static OpenDialog readAction(String uniqueId, AppModel app) => OpenDialog(app,
      dialogID: constructDocumentId(uniqueId: uniqueId, documentId: IDENTIFIER_READ),
      conditions: DisplayConditionsModel(
          privilegeLevelRequired: PrivilegeLevelRequired.NoPrivilegeRequired,
          packageCondition: ChatPackage.CONDITION_MEMBER_ALL_HAVE_BEEN_READ));

  static String CHAT_ID = "chat";

  Future<DialogModel> _setupDialog(String identifier) async {
    return await corerepo.AbstractRepositorySingleton.singleton
        .dialogRepository(app.documentID)!
        .add(_dialog(identifier));
  }

  DialogModel _dialog(String identifier) {
    List<BodyComponentModel> components = [];
    components.add(BodyComponentModel(
        documentID: "1",
        componentName: AbstractChatDashboardComponent.componentName,
        componentId: CHAT_ID));

    return DialogModel(
        documentID: constructDocumentId(uniqueId: uniqueId, documentId: identifier),
        appId: app.documentID,
        title: "Chat",
        description: "Chat",
        includeHeading: false,
        layout: DialogLayout.ListView,
        conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple,
        ),
        bodyComponents: components);
  }

  ChatDashboardModel _chatModel() {
    return ChatDashboardModel(
      documentID: CHAT_ID,
      appId: app.documentID,
      description: "Chat",
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.NoPrivilegeRequiredSimple),
    );
  }

  Future<ChatDashboardModel> _setupChat() async {
    return await AbstractRepositorySingleton.singleton
        .chatDashboardRepository(app.documentID)!
        .add(_chatModel());
  }

  Future<void> create() async {
    await _setupChat();
    await _setupDialog(IDENTIFIER_READ);
    await _setupDialog(IDENTIFIER_UNREAD);
  }
}
