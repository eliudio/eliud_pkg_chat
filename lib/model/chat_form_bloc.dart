/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_form_bloc.dart
                       
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

import 'package:eliud_pkg_chat/model/chat_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_form_state.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';

class ChatFormBloc extends Bloc<ChatFormEvent, ChatFormState> {
  final FormAction? formAction;
  final String? appId;

  ChatFormBloc(this.appId, { this.formAction }): super(ChatFormUninitialized());
  @override
  Stream<ChatFormState> mapEventToState(ChatFormEvent event) async* {
    final currentState = state;
    if (currentState is ChatFormUninitialized) {
      on <InitialiseNewChatFormEvent> ((event, emit) {
        ChatFormLoaded loaded = ChatFormLoaded(value: ChatModel(
                                               documentID: "",
                                 authorId: "",
                                 appId: "",
                                 roomId: "",
                                 saying: "",
                                 accessibleByMembers: [],
                                 readAccess: [],
                                 chatMedia: [],

        ));
        emit(loaded);
      });


      if (event is InitialiseChatFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        ChatFormLoaded loaded = ChatFormLoaded(value: await chatRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      } else if (event is InitialiseChatFormNoLoadEvent) {
        ChatFormLoaded loaded = ChatFormLoaded(value: event.value);
        emit(loaded);
      }
    } else if (currentState is ChatFormInitialized) {
      ChatModel? newValue = null;
      on <ChangedChatDocumentID> ((event, emit) async {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableChatForm(value: newValue));
        }

      });
      on <ChangedChatAuthorId> ((event, emit) async {
        newValue = currentState.value!.copyWith(authorId: event.value);
        emit(SubmittableChatForm(value: newValue));

      });
      on <ChangedChatAppId> ((event, emit) async {
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableChatForm(value: newValue));

      });
      on <ChangedChatRoomId> ((event, emit) async {
        newValue = currentState.value!.copyWith(roomId: event.value);
        emit(SubmittableChatForm(value: newValue));

      });
      on <ChangedChatTimestamp> ((event, emit) async {
        newValue = currentState.value!.copyWith(timestamp: dateTimeFromTimestampString(event.value!));
        emit(SubmittableChatForm(value: newValue));

      });
      on <ChangedChatSaying> ((event, emit) async {
        newValue = currentState.value!.copyWith(saying: event.value);
        emit(SubmittableChatForm(value: newValue));

      });
      on <ChangedChatAccessibleByGroup> ((event, emit) async {
        newValue = currentState.value!.copyWith(accessibleByGroup: event.value);
        emit(SubmittableChatForm(value: newValue));

      });
      on <ChangedChatChatMedia> ((event, emit) async {
        newValue = currentState.value!.copyWith(chatMedia: event.value);
        emit(SubmittableChatForm(value: newValue));

      });
    }
  }


  DocumentIDChatFormError error(String message, ChatModel newValue) => DocumentIDChatFormError(message: message, value: newValue);

  Future<ChatFormState> _isDocumentIDValid(String? value, ChatModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<ChatModel?> findDocument = chatRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableChatForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

