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

  Stream<RoomComponentState> _mapLoadRoomComponentUpdateToState(String documentId) async* {
    _roomSubscription?.cancel();
    _roomSubscription = roomRepository!.listenTo(documentId, (value) {
      if (value != null) add(RoomComponentUpdated(value: value));
    });
  }

  RoomComponentBloc({ this.roomRepository }): super(RoomComponentUninitialized());

  @override
  Stream<RoomComponentState> mapEventToState(RoomComponentEvent event) async* {
    final currentState = state;
    if (event is FetchRoomComponent) {
      yield* _mapLoadRoomComponentUpdateToState(event.id!);
    } else if (event is RoomComponentUpdated) {
      yield RoomComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _roomSubscription?.cancel();
    return super.close();
  }

}

