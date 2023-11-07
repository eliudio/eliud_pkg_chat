/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/component_registry.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import '../model/internal_component.dart';
import 'package:eliud_core/core/registry.dart';
import 'package:eliud_core/tools/component/component_spec.dart';
import 'abstract_repository_singleton.dart';

import '../extensions/chat_dashboard_component.dart';
import '../editors/chat_dashboard_component_editor.dart';
import 'chat_dashboard_component_selector.dart';

class ComponentRegistry {
  void init() {
    Registry.registry()!.addInternalComponents('eliud_pkg_chat', [
      "chats",
      "chatDashboards",
      "chatMemberInfos",
      "memberHasChats",
      "rooms",
    ]);

    Registry.registry()!.register(
        componentName: "eliud_pkg_chat_internalWidgets",
        componentConstructor: ListComponentFactory());
    Registry.registry()!.addDropDownSupporter(
        "chatDashboards", DropdownButtonComponentFactory());
    Registry.registry()!.register(
        componentName: "chatDashboards",
        componentConstructor: ChatDashboardComponentConstructorDefault());
    Registry.registry()!.addComponentSpec('eliud_pkg_chat', 'chat', [
      ComponentSpec(
          'chatDashboards',
          ChatDashboardComponentConstructorDefault(),
          ChatDashboardComponentSelector(),
          ChatDashboardComponentEditorConstructor(),
          ({String? appId}) => chatDashboardRepository(appId: appId)!),
    ]);
    Registry.registry()!.registerRetrieveRepository(
        'eliud_pkg_chat',
        'chatDashboards',
        ({String? appId}) => chatDashboardRepository(appId: appId)!);
    Registry.registry()!.registerRetrieveRepository(
        'eliud_pkg_chat',
        'memberHasChats',
        ({String? appId}) => memberHasChatRepository(appId: appId)!);
    Registry.registry()!.registerRetrieveRepository('eliud_pkg_chat', 'rooms',
        ({String? appId}) => roomRepository(appId: appId)!);
  }
}
