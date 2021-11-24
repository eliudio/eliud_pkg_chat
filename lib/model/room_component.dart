/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_component.dart
                       
 This code is generated. This is read only. Don't touch!

*/


import 'package:eliud_pkg_chat/model/room_component_bloc.dart';
import 'package:eliud_pkg_chat/model/room_component_event.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/model/room_repository.dart';
import 'package:eliud_pkg_chat/model/room_component_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core/core/widgets/alert_widget.dart';
import 'package:eliud_core/tools/main_abstract_repository_singleton.dart';

abstract class AbstractRoomComponent extends StatelessWidget {
  static String componentName = "rooms";
  final String theAppId;
  final String roomId;

  AbstractRoomComponent({Key? key, required this.theAppId, required this.roomId}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomComponentBloc> (
          create: (context) => RoomComponentBloc(
            roomRepository: roomRepository(appId: theAppId)!)
        ..add(FetchRoomComponent(id: roomId)),
      child: _roomBlockBuilder(context),
    );
  }

  Widget _roomBlockBuilder(BuildContext context) {
    return BlocBuilder<RoomComponentBloc, RoomComponentState>(builder: (context, state) {
      if (state is RoomComponentLoaded) {
        if (state.value == null) {
          return AlertWidget(title: "Error", content: 'No Room defined');
        } else {
          return yourWidget(context, state.value);
        }
      } else if (state is RoomComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is RoomComponentError) {
        return AlertWidget(title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithContext(context).frontEndStyle().progressIndicatorStyle().progressIndicator(context),
        );
      }
    });
  }

  Widget yourWidget(BuildContext context, RoomModel value);
}

