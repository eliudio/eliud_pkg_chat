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

import '../extensions/chat_dashboard_component.dart';
import 'package:eliud_pkg_chat/model/internal_component.dart';




class ComponentRegistry {

  void init() {
    Registry.registry()!.addInternalComponents('eliud_pkg_chat', ["chats", "chatDashboards", "rooms", ]);

    Registry.registry()!.register(componentName: "eliud_pkg_chat_internalWidgets", componentConstructor: ListComponentFactory());
    Registry.registry()!.addDropDownSupporter("chatDashboards", DropdownButtonComponentFactory());
    Registry.registry()!.register(componentName: "chatDashboards", componentConstructor: ChatDashboardComponentConstructorDefault());

  }
}


