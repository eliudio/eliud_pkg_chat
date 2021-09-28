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
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eliud_core/tools/has_fab.dart';


import 'package:eliud_pkg_chat/model/chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_list.dart';
import 'package:eliud_pkg_chat/model/chat_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/chat_list_event.dart';

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

import 'package:eliud_pkg_chat/model/chat_dashboard_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_list_event.dart';

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

import 'package:eliud_pkg_chat/model/chat_member_info_list_bloc.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart';

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

import 'package:eliud_pkg_chat/model/member_has_chat_list_bloc.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_list.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_list_event.dart';

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

import 'package:eliud_pkg_chat/model/room_list_bloc.dart';
import 'package:eliud_pkg_chat/model/room_list.dart';
import 'package:eliud_pkg_chat/model/room_dropdown_button.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';

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

class ListComponentFactory implements ComponentConstructor {
  Widget? createNew({Key? key, required String id, Map<String, dynamic>? parameters}) {
    return ListComponent(componentId: id);
  }
}


typedef DropdownButtonChanged(String? value);

class DropdownButtonComponentFactory implements ComponentDropDown {

  bool supports(String id) {

    if (id == "chats") return true;
    if (id == "chatDashboards") return true;
    if (id == "chatMemberInfos") return true;
    if (id == "memberHasChats") return true;
    if (id == "rooms") return true;
    return false;
  }

  Widget createNew({Key? key, required String id, Map<String, dynamic>? parameters, String? value, DropdownButtonChanged? trigger, bool? optional}) {

    if (id == "chats")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "chatDashboards")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "chatMemberInfos")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "memberHasChats")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    if (id == "rooms")
      return DropdownButtonComponent(componentId: id, value: value, trigger: trigger, optional: optional);

    return Text("Id $id not found");
  }
}


class ListComponent extends StatelessWidget with HasFab {
  final String? componentId;
  Widget? widget;

  @override
  Widget? fab(BuildContext context){
    if ((widget != null) && (widget is HasFab)) {
      HasFab hasFab = widget as HasFab;
      return hasFab.fab(context);
    }
    return null;
  }

  ListComponent({this.componentId}) {
    initWidget();
  }

  @override
  Widget build(BuildContext context) {

    if (componentId == 'chats') return _chatBuild(context);
    if (componentId == 'chatDashboards') return _chatDashboardBuild(context);
    if (componentId == 'chatMemberInfos') return _chatMemberInfoBuild(context);
    if (componentId == 'memberHasChats') return _memberHasChatBuild(context);
    if (componentId == 'rooms') return _roomBuild(context);
    return Text('Component with componentId == $componentId not found');
  }

  void initWidget() {
    if (componentId == 'chats') widget = ChatListWidget();
    if (componentId == 'chatDashboards') widget = ChatDashboardListWidget();
    if (componentId == 'chatMemberInfos') widget = ChatMemberInfoListWidget();
    if (componentId == 'memberHasChats') widget = MemberHasChatListWidget();
    if (componentId == 'rooms') widget = RoomListWidget();
  }

  Widget _chatBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatListBloc>(
          create: (context) => ChatListBloc(
            chatRepository: chatRepository(appId: AccessBloc.appId(context))!,
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
            chatDashboardRepository: chatDashboardRepository(appId: AccessBloc.appId(context))!,
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
            chatMemberInfoRepository: chatMemberInfoRepository(appId: AccessBloc.appId(context))!,
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
            memberHasChatRepository: memberHasChatRepository(appId: AccessBloc.appId(context))!,
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
            roomRepository: roomRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadRoomList()),
        )
      ],
      child: widget!,
    );
  }

}


typedef Changed(String? value);

class DropdownButtonComponent extends StatelessWidget {
  final String? componentId;
  final String? value;
  final Changed? trigger;
  final bool? optional;

  DropdownButtonComponent({this.componentId, this.value, this.trigger, this.optional});

  @override
  Widget build(BuildContext context) {

    if (componentId == 'chats') return _chatBuild(context);
    if (componentId == 'chatDashboards') return _chatDashboardBuild(context);
    if (componentId == 'chatMemberInfos') return _chatMemberInfoBuild(context);
    if (componentId == 'memberHasChats') return _memberHasChatBuild(context);
    if (componentId == 'rooms') return _roomBuild(context);
    return Text('Component with componentId == $componentId not found');
  }


  Widget _chatBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatListBloc>(
          create: (context) => ChatListBloc(
            chatRepository: chatRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadChatList()),
        )
      ],
      child: ChatDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _chatDashboardBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatDashboardListBloc>(
          create: (context) => ChatDashboardListBloc(
            chatDashboardRepository: chatDashboardRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadChatDashboardList()),
        )
      ],
      child: ChatDashboardDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _chatMemberInfoBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatMemberInfoListBloc>(
          create: (context) => ChatMemberInfoListBloc(
            chatMemberInfoRepository: chatMemberInfoRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadChatMemberInfoList()),
        )
      ],
      child: ChatMemberInfoDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _memberHasChatBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MemberHasChatListBloc>(
          create: (context) => MemberHasChatListBloc(
            memberHasChatRepository: memberHasChatRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadMemberHasChatList()),
        )
      ],
      child: MemberHasChatDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

  Widget _roomBuild(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomListBloc>(
          create: (context) => RoomListBloc(
            roomRepository: roomRepository(appId: AccessBloc.appId(context))!,
          )..add(LoadRoomList()),
        )
      ],
      child: RoomDropdownButtonWidget(value: value, trigger: trigger, optional: optional),
    );
  }

}


