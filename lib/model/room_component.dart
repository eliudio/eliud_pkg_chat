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
import 'package:eliud_core_model/style/style_registry.dart';
import 'abstract_repository_singleton.dart';
import 'package:eliud_core_model/widgets/alert_widget.dart';
import 'package:eliud_core_model/tools/main_abstract_repository_singleton.dart';
import 'package:eliud_core_model/model/app_model.dart';

/*
 * AbstractRoomComponent is the base class to extend / implement in case you need to implement a component
 */
abstract class AbstractRoomComponent extends StatelessWidget {
  static String componentName = "rooms";
  final AppModel app;
  final String roomId;

  /*
   * Construct AbstractRoomComponent
   */
  AbstractRoomComponent({Key? key, required this.app, required this.roomId}): super(key: key);

  /*
   * build the component
   */
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomComponentBloc> (
          create: (context) => RoomComponentBloc(
            roomRepository: roomRepository(appId: app.documentID)!)
        ..add(FetchRoomComponent(id: roomId)),
      child: _roomBlockBuilder(context),
    );
  }

  Widget _roomBlockBuilder(BuildContext context) {
    return BlocBuilder<RoomComponentBloc, RoomComponentState>(builder: (context, state) {
      if (state is RoomComponentLoaded) {
        return yourWidget(context, state.value);
      } else if (state is RoomComponentPermissionDenied) {
        return Icon(
          Icons.highlight_off,
          color: Colors.red,
          size: 30.0,
        );
      } else if (state is RoomComponentError) {
        return AlertWidget(app: app, title: 'Error', content: state.message);
      } else {
        return Center(
          child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().progressIndicatorStyle().progressIndicator(app, context),
        );
      }
    });
  }

  /*
   * Implement this method to provide your widget
   */
  Widget yourWidget(BuildContext context, RoomModel value);
}

