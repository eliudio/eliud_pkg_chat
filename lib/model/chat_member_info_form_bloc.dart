/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_form_bloc.dart
                       
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

import 'package:eliud_pkg_chat/model/chat_member_info_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_state.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_repository.dart';

class ChatMemberInfoFormBloc extends Bloc<ChatMemberInfoFormEvent, ChatMemberInfoFormState> {
  final FormAction? formAction;
  final String? appId;

  ChatMemberInfoFormBloc(this.appId, { this.formAction }): super(ChatMemberInfoFormUninitialized());
  @override
  Stream<ChatMemberInfoFormState> mapEventToState(ChatMemberInfoFormEvent event) async* {
    final currentState = state;
    if (currentState is ChatMemberInfoFormUninitialized) {
      if (event is InitialiseNewChatMemberInfoFormEvent) {
        ChatMemberInfoFormLoaded loaded = ChatMemberInfoFormLoaded(value: ChatMemberInfoModel(
                                               documentID: "",
                                 authorId: "",
                                 appId: "",
                                 roomId: "",
                                 readAccess: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseChatMemberInfoFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        ChatMemberInfoFormLoaded loaded = ChatMemberInfoFormLoaded(value: await chatMemberInfoRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseChatMemberInfoFormNoLoadEvent) {
        ChatMemberInfoFormLoaded loaded = ChatMemberInfoFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is ChatMemberInfoFormInitialized) {
      ChatMemberInfoModel? newValue = null;
      if (event is ChangedChatMemberInfoDocumentID) {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableChatMemberInfoForm(value: newValue);
        }

        return;
      }
      if (event is ChangedChatMemberInfoAuthorId) {
        newValue = currentState.value!.copyWith(authorId: event.value);
        yield SubmittableChatMemberInfoForm(value: newValue);

        return;
      }
      if (event is ChangedChatMemberInfoAppId) {
        newValue = currentState.value!.copyWith(appId: event.value);
        yield SubmittableChatMemberInfoForm(value: newValue);

        return;
      }
      if (event is ChangedChatMemberInfoRoomId) {
        newValue = currentState.value!.copyWith(roomId: event.value);
        yield SubmittableChatMemberInfoForm(value: newValue);

        return;
      }
      if (event is ChangedChatMemberInfoTimestamp) {
        newValue = currentState.value!.copyWith(timestamp: dateTimeFromTimestampString(event.value!));
        yield SubmittableChatMemberInfoForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDChatMemberInfoFormError error(String message, ChatMemberInfoModel newValue) => DocumentIDChatMemberInfoFormError(message: message, value: newValue);

  Future<ChatMemberInfoFormState> _isDocumentIDValid(String? value, ChatMemberInfoModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<ChatMemberInfoModel?> findDocument = chatMemberInfoRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableChatMemberInfoForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

