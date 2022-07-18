/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_form_bloc.dart
                       
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

import 'package:eliud_pkg_chat/model/member_has_chat_form_event.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_form_state.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_repository.dart';

class MemberHasChatFormBloc extends Bloc<MemberHasChatFormEvent, MemberHasChatFormState> {
  final FormAction? formAction;
  final String? appId;

  MemberHasChatFormBloc(this.appId, { this.formAction }): super(MemberHasChatFormUninitialized()) {
      on <InitialiseNewMemberHasChatFormEvent> ((event, emit) {
        MemberHasChatFormLoaded loaded = MemberHasChatFormLoaded(value: MemberHasChatModel(
                                               documentID: "",
                                 memberId: "",
                                 appId: "",

        ));
        emit(loaded);
      });


      on <InitialiseMemberHasChatFormEvent> ((event, emit) async {
        // Need to re-retrieve the document from the repository so that I get all associated types
        MemberHasChatFormLoaded loaded = MemberHasChatFormLoaded(value: await memberHasChatRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      });
      on <InitialiseMemberHasChatFormNoLoadEvent> ((event, emit) async {
        MemberHasChatFormLoaded loaded = MemberHasChatFormLoaded(value: event.value);
        emit(loaded);
      });
      MemberHasChatModel? newValue = null;
      on <ChangedMemberHasChatDocumentID> ((event, emit) async {
      if (state is MemberHasChatFormInitialized) {
        final currentState = state as MemberHasChatFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableMemberHasChatForm(value: newValue));
        }

      }
      });
      on <ChangedMemberHasChatMemberId> ((event, emit) async {
      if (state is MemberHasChatFormInitialized) {
        final currentState = state as MemberHasChatFormInitialized;
        newValue = currentState.value!.copyWith(memberId: event.value);
        emit(SubmittableMemberHasChatForm(value: newValue));

      }
      });
      on <ChangedMemberHasChatAppId> ((event, emit) async {
      if (state is MemberHasChatFormInitialized) {
        final currentState = state as MemberHasChatFormInitialized;
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableMemberHasChatForm(value: newValue));

      }
      });
      on <ChangedMemberHasChatHasUnread> ((event, emit) async {
      if (state is MemberHasChatFormInitialized) {
        final currentState = state as MemberHasChatFormInitialized;
        newValue = currentState.value!.copyWith(hasUnread: event.value);
        emit(SubmittableMemberHasChatForm(value: newValue));

      }
      });
  }


  DocumentIDMemberHasChatFormError error(String message, MemberHasChatModel newValue) => DocumentIDMemberHasChatFormError(message: message, value: newValue);

  Future<MemberHasChatFormState> _isDocumentIDValid(String? value, MemberHasChatModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<MemberHasChatModel?> findDocument = memberHasChatRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableMemberHasChatForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

