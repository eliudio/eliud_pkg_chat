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
  StreamSubscription? _memberHasChatSubscription;

  void _mapLoadMemberHasChatComponentUpdateToState(String documentId) {
    _memberHasChatSubscription?.cancel();
    _memberHasChatSubscription = memberHasChatRepository!.listenTo(documentId, (value) {
      if (value != null) {
        add(MemberHasChatComponentUpdated(value: value));
      }
    });
  }

  /*
   * Construct MemberHasChatComponentBloc
   */
  MemberHasChatComponentBloc({ this.memberHasChatRepository }): super(MemberHasChatComponentUninitialized()) {
    on <FetchMemberHasChatComponent> ((event, emit) {
      _mapLoadMemberHasChatComponentUpdateToState(event.id!);
    });
    on <MemberHasChatComponentUpdated> ((event, emit) {
      emit(MemberHasChatComponentLoaded(value: event.value));
    });
  }

  /*
   * Close the MemberHasChatComponentBloc
   */
  @override
  Future<void> close() {
    _memberHasChatSubscription?.cancel();
    return super.close();
  }

}

