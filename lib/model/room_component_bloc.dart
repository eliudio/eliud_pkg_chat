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
  StreamSubscription? _roomSubscription;

  void _mapLoadRoomComponentUpdateToState(String documentId) {
    _roomSubscription?.cancel();
    _roomSubscription = roomRepository!.listenTo(documentId, (value) {
      if (value != null) {
        add(RoomComponentUpdated(value: value));
      }
    });
  }

  RoomComponentBloc({ this.roomRepository }): super(RoomComponentUninitialized()) {
    on <FetchRoomComponent> ((event, emit) {
      _mapLoadRoomComponentUpdateToState(event.id!);
    });
    on <RoomComponentUpdated> ((event, emit) {
      emit(RoomComponentLoaded(value: event.value));
    });
  }

  @override
  Future<void> close() {
    _roomSubscription?.cancel();
    return super.close();
  }

}

