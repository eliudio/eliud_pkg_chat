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

  Stream<MemberHasChatComponentState> _mapLoadMemberHasChatComponentUpdateToState(String documentId) async* {
    _memberHasChatSubscription?.cancel();
    _memberHasChatSubscription = memberHasChatRepository!.listenTo(documentId, (value) {
      if (value != null) add(MemberHasChatComponentUpdated(value: value));
    });
  }

  MemberHasChatComponentBloc({ this.memberHasChatRepository }): super(MemberHasChatComponentUninitialized());

  @override
  Stream<MemberHasChatComponentState> mapEventToState(MemberHasChatComponentEvent event) async* {
    final currentState = state;
    if (event is FetchMemberHasChatComponent) {
      yield* _mapLoadMemberHasChatComponentUpdateToState(event.id!);
    } else if (event is MemberHasChatComponentUpdated) {
      yield MemberHasChatComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _memberHasChatSubscription?.cancel();
    return super.close();
  }

}

