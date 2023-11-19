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
import 'package:eliud_core_model/tools/component/component_spec.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_model/tools/component/component_constructor.dart';
import 'package:eliud_core_model/apis/apis.dart';

import 'chat_dashboard_component_selector.dart';
import 'package:eliud_pkg_chat/model/internal_component.dart';




/* 
 * Component registry contains a list of components
 */
class ComponentRegistry {

  /* 
   * Initialise the component registry
   */
  init(ComponentConstructor chatDashboardComponentConstructorDefault, ComponentEditorConstructor chatDashboardComponentEditorConstructor, ) {
    Apis.apis().getRegistryApi().addInternalComponents('eliud_pkg_chat', ["chats", "chatDashboards", "chatMemberInfos", "memberHasChats", "rooms", ]);

    Apis.apis().getRegistryApi().register(componentName: "eliud_pkg_chat_internalWidgets", componentConstructor: ListComponentFactory());
    Apis.apis().getRegistryApi().addDropDownSupporter("chatDashboards", DropdownButtonComponentFactory());
    Apis.apis().getRegistryApi().register(componentName: "chatDashboards", componentConstructor: chatDashboardComponentConstructorDefault);
    Apis.apis().getRegistryApi().addComponentSpec('eliud_pkg_chat', 'chat', [
      ComponentSpec('chatDashboards', chatDashboardComponentConstructorDefault, ChatDashboardComponentSelector(), chatDashboardComponentEditorConstructor, ({String? appId}) => chatDashboardRepository(appId: appId)! ), 
    ]);
      Apis.apis().getRegistryApi().registerRetrieveRepository('eliud_pkg_chat', 'chatDashboards', ({String? appId}) => chatDashboardRepository(appId: appId)!);
      Apis.apis().getRegistryApi().registerRetrieveRepository('eliud_pkg_chat', 'memberHasChats', ({String? appId}) => memberHasChatRepository(appId: appId)!);
      Apis.apis().getRegistryApi().registerRetrieveRepository('eliud_pkg_chat', 'rooms', ({String? appId}) => roomRepository(appId: appId)!);
  }

}


