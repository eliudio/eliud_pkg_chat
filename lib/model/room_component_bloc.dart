/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:eliud_pkg_chat/model/room_component_event.dart';
import 'package:eliud_pkg_chat/model/room_component_state.dart';
import 'package:eliud_pkg_chat/model/room_repository.dart';
import 'package:flutter/services.dart';

class RoomComponentBloc extends Bloc<RoomComponentEvent, RoomComponentState> {
  final RoomRepository? roomRepository;

  RoomComponentBloc({ this.roomRepository }): super(RoomComponentUninitialized());
  @override
  Stream<RoomComponentState> mapEventToState(RoomComponentEvent event) async* {
    final currentState = state;
    if (event is FetchRoomComponent) {
      try {
        if (currentState is RoomComponentUninitialized) {
          bool permissionDenied = false;
          final model = await roomRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield RoomComponentPermissionDenied();
          } else {
            if (model != null) {
              yield RoomComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield RoomComponentError(
                  message: "Room with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield RoomComponentError(message: "Unknown error whilst retrieving Room");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

