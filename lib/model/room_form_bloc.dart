/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/tools/firestore/firestore_tools.dart';
import 'package:flutter/cupertino.dart';

import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/tools/common_tools.dart';

import 'package:eliud_core/model/rgb_model.dart';

import 'package:eliud_core/tools/string_validator.dart';

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

import 'package:eliud_pkg_chat/model/room_form_event.dart';
import 'package:eliud_pkg_chat/model/room_form_state.dart';
import 'package:eliud_pkg_chat/model/room_repository.dart';

class RoomFormBloc extends Bloc<RoomFormEvent, RoomFormState> {
  final FormAction? formAction;
  final String? appId;

  RoomFormBloc(this.appId, { this.formAction }): super(RoomFormUninitialized());
  @override
  Stream<RoomFormState> mapEventToState(RoomFormEvent event) async* {
    final currentState = state;
    if (currentState is RoomFormUninitialized) {
      on <InitialiseNewRoomFormEvent> ((event, emit) {
        RoomFormLoaded loaded = RoomFormLoaded(value: RoomModel(
                                               documentID: "",
                                 ownerId: "",
                                 appId: "",
                                 description: "",
                                 members: [],

        ));
        emit(loaded);
      });


      if (event is InitialiseRoomFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        RoomFormLoaded loaded = RoomFormLoaded(value: await roomRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      } else if (event is InitialiseRoomFormNoLoadEvent) {
        RoomFormLoaded loaded = RoomFormLoaded(value: event.value);
        emit(loaded);
      }
    } else if (currentState is RoomFormInitialized) {
      RoomModel? newValue = null;
      on <ChangedRoomDocumentID> ((event, emit) async {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableRoomForm(value: newValue));
        }

      });
      on <ChangedRoomOwnerId> ((event, emit) async {
        newValue = currentState.value!.copyWith(ownerId: event.value);
        emit(SubmittableRoomForm(value: newValue));

      });
      on <ChangedRoomAppId> ((event, emit) async {
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableRoomForm(value: newValue));

      });
      on <ChangedRoomDescription> ((event, emit) async {
        newValue = currentState.value!.copyWith(description: event.value);
        emit(SubmittableRoomForm(value: newValue));

      });
      on <ChangedRoomIsRoom> ((event, emit) async {
        newValue = currentState.value!.copyWith(isRoom: event.value);
        emit(SubmittableRoomForm(value: newValue));

      });
      on <ChangedRoomTimestamp> ((event, emit) async {
        newValue = currentState.value!.copyWith(timestamp: dateTimeFromTimestampString(event.value!));
        emit(SubmittableRoomForm(value: newValue));

      });
    }
  }


  DocumentIDRoomFormError error(String message, RoomModel newValue) => DocumentIDRoomFormError(message: message, value: newValue);

  Future<RoomFormState> _isDocumentIDValid(String? value, RoomModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<RoomModel?> findDocument = roomRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableRoomForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

