/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 model/internal_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/component/component_constructor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'package:eliud_core/tools/has_fab.dart';

import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list.dart';
import 'package:eliud_pkg_chat/model/chat_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';

import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_core/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_dashboard_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_event.dart';

import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart';

import 'package:eliud_pkg_chat/model/member_has_chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_list.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_list_event.dart';

import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list.dart';
import 'package:eliud_pkg_chat/model/room_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';

class ListComponentFactory implements ComponentConstructor {
  @override
  Widget? createNew(
      {Key? key,
      required AppModel app,
      required String id,
      int? privilegeLevel,
      Map<String, dynamic>? parameters}) {
    return ListComponent(app: app, componentId: id);
  }

  @override
  dynamic getModel({required AppModel app, required String id}) {
    return null;
  }
}

typedef DropdownButtonChanged = Function(String? value, int? privilegeLevel);

class DropdownButtonComponentFactory implements ComponentDropDown {
  @override
  dynamic getModel({required AppModel app, required String id}) {
    return null;
  }

  @override
  bool supports(String id) {
    if (id == "chats") return true;
    if (id == "chatDashboards") return true;
    if (id == "chatMemberInfos") return true;
    if (id == "memberHasChats") return true;
    if (id == "rooms") return true;
    return false;
  }

  @override
  Widget createNew(
      {Key? key,
      required AppModel app,
      required String id,
      int? privilegeLevel,
      Map<String, dynamic>? parameters,
      String? value,
      DropdownButtonChanged? trigger,
      bool? optional}) {
    if (id == "chats") {
      return DropdownButtonComponent(
          app: app,
          componentId: id,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional);
    }

    if (id == "chatDashboards") {
      return DropdownButtonComponent(
          app: app,
          componentId: id,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional);
    }

    if (id == "chatMemberInfos") {
      return DropdownButtonComponent(
          app: app,
          componentId: id,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional);
    }

    if (id == "memberHasChats") {
      return DropdownButtonComponent(
          app: app,
          componentId: id,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional);
    }

    if (id == "rooms") {
      return DropdownButtonComponent(
          app: app,
          componentId: id,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional);
    }

    return Text("Id $id not found");
  }
}

class ListComponent extends StatelessWidget with HasFab {
  final AppModel app;
  final String? componentId;
  final Widget? widget;
  final int? privilegeLevel;

  @override
  Widget? fab(BuildContext context) {
    if ((widget != null) && (widget is HasFab)) {
      HasFab hasFab = widget as HasFab;
      return hasFab.fab(context);
    }
    return null;
  }

  ListComponent({required this.app, this.privilegeLevel, this.componentId})
      : widget = getWidget(componentId, app);

  @override
  Widget build(BuildContext context) {
    if (componentId == 'chats') {
      return _chatBuild(context);
    }
    if (componentId == 'chatDashboards') {
      return _chatDashboardBuild(context);
    }
    if (componentId == 'chatMemberInfos') {
      return _chatMemberInfoBuild(context);
    }
    if (componentId == 'memberHasChats') {
      return _memberHasChatBuild(context);
    }
    if (componentId == 'rooms') {
      return _roomBuild(context);
    }
    return Text('Component with componentId == $componentId not found');
  }

  static Widget getWidget(String? componentId, AppModel app) {
    if (componentId == 'chats') {
      return ChatListWidget(app: app);
    }
    if (componentId == 'chatDashboards') {
      return ChatDashboardListWidget(app: app);
    }
    if (componentId == 'chatMemberInfos') {
      return ChatMemberInfoListWidget(app: app);
    }
    if (componentId == 'memberHasChats') {
      return MemberHasChatListWidget(app: app);
    }
    if (componentId == 'rooms') {
      return RoomListWidget(app: app);
    }
    return Container();
  }

  Widget _chatBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatListBloc>(
          create: (context) => ChatListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            chatRepository: chatRepository(appId: app.documentID)!,
          )..add(LoadChatList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _chatDashboardBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatDashboardListBloc>(
          create: (context) => ChatDashboardListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            chatDashboardRepository:
                chatDashboardRepository(appId: app.documentID)!,
          )..add(LoadChatDashboardList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _chatMemberInfoBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatMemberInfoListBloc>(
          create: (context) => ChatMemberInfoListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            chatMemberInfoRepository:
                chatMemberInfoRepository(appId: app.documentID)!,
          )..add(LoadChatMemberInfoList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _memberHasChatBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MemberHasChatListBloc>(
          create: (context) => MemberHasChatListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            memberHasChatRepository:
                memberHasChatRepository(appId: app.documentID)!,
          )..add(LoadMemberHasChatList()),
        )
      ],
      child: widget!,
    );
  }

  Widget _roomBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomListBloc>(
          create: (context) => RoomListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            roomRepository: roomRepository(appId: app.documentID)!,
          )..add(LoadRoomList()),
        )
      ],
      child: widget!,
    );
  }
}

typedef Changed = Function(String? value, int? privilegeLevel);

class DropdownButtonComponent extends StatelessWidget {
  final AppModel app;
  final String? componentId;
  final String? value;
  final Changed? trigger;
  final bool? optional;
  final int? privilegeLevel;

  DropdownButtonComponent(
      {required this.app,
      this.componentId,
      this.privilegeLevel,
      this.value,
      this.trigger,
      this.optional});

  @override
  Widget build(BuildContext context) {
    if (componentId == 'chats') {
      return _chatBuild(context);
    }
    if (componentId == 'chatDashboards') {
      return _chatDashboardBuild(context);
    }
    if (componentId == 'chatMemberInfos') {
      return _chatMemberInfoBuild(context);
    }
    if (componentId == 'memberHasChats') {
      return _memberHasChatBuild(context);
    }
    if (componentId == 'rooms') {
      return _roomBuild(context);
    }
    return Text('Component with componentId == $componentId not found');
  }

  Widget _chatBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatListBloc>(
          create: (context) => ChatListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            chatRepository: chatRepository(appId: app.documentID)!,
          )..add(LoadChatList()),
        )
      ],
      child: ChatDropdownButtonWidget(
          app: app,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional),
    );
  }

  Widget _chatDashboardBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatDashboardListBloc>(
          create: (context) => ChatDashboardListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            chatDashboardRepository:
                chatDashboardRepository(appId: app.documentID)!,
          )..add(LoadChatDashboardList()),
        )
      ],
      child: ChatDashboardDropdownButtonWidget(
          app: app,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional),
    );
  }

  Widget _chatMemberInfoBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatMemberInfoListBloc>(
          create: (context) => ChatMemberInfoListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            chatMemberInfoRepository:
                chatMemberInfoRepository(appId: app.documentID)!,
          )..add(LoadChatMemberInfoList()),
        )
      ],
      child: ChatMemberInfoDropdownButtonWidget(
          app: app,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional),
    );
  }

  Widget _memberHasChatBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MemberHasChatListBloc>(
          create: (context) => MemberHasChatListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            memberHasChatRepository:
                memberHasChatRepository(appId: app.documentID)!,
          )..add(LoadMemberHasChatList()),
        )
      ],
      child: MemberHasChatDropdownButtonWidget(
          app: app,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional),
    );
  }

  Widget _roomBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomListBloc>(
          create: (context) => RoomListBloc(
            eliudQuery: EliudQuery(theConditions: [
              EliudQueryCondition('conditions.privilegeLevelRequired',
                  isEqualTo: privilegeLevel ?? 0),
              EliudQueryCondition('appId', isEqualTo: app.documentID),
            ]),
            roomRepository: roomRepository(appId: app.documentID)!,
          )..add(LoadRoomList()),
        )
      ],
      child: RoomDropdownButtonWidget(
          app: app,
          value: value,
          privilegeLevel: privilegeLevel,
          trigger: trigger,
          optional: optional),
    );
  }
}
