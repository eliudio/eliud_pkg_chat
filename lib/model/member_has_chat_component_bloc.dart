/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_chat/model/member_has_chat_model.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_component_event.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_component_state.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_repository.dart';
import 'package:flutter/services.dart';

class MemberHasChatComponentBloc extends Bloc<MemberHasChatComponentEvent, MemberHasChatComponentState> {
  final MemberHasChatRepository? memberHasChatRepository;

  MemberHasChatComponentBloc({ this.memberHasChatRepository }): super(MemberHasChatComponentUninitialized());
  @override
  Stream<MemberHasChatComponentState> mapEventToState(MemberHasChatComponentEvent event) async* {
    final currentState = state;
    if (event is FetchMemberHasChatComponent) {
      try {
        if (currentState is MemberHasChatComponentUninitialized) {
          bool permissionDenied = false;
          final model = await memberHasChatRepository!.get(event.id, onError: (error) {
            // Unfortunatly the below is currently the only way we know how to identify if a document is read protected
            if ((error is PlatformException) &&  (error.message!.startsWith("PERMISSION_DENIED"))) {
              permissionDenied = true;
            }
          });
          if (permissionDenied) {
            yield MemberHasChatComponentPermissionDenied();
          } else {
            if (model != null) {
              yield MemberHasChatComponentLoaded(value: model);
            } else {
              String? id = event.id;
              yield MemberHasChatComponentError(
                  message: "MemberHasChat with id = '$id' not found");
            }
          }
          return;
        }
      } catch (_) {
        yield MemberHasChatComponentError(message: "Unknown error whilst retrieving MemberHasChat");
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

