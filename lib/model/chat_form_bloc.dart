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
      if (event is InitialiseNewChatFormEvent) {
        ChatFormLoaded loaded = ChatFormLoaded(value: ChatModel(
                                               documentID: "",
                                 authorId: "",
                                 appId: "",
                                 roomId: "",
                                 saying: "",
                                 readAccess: [],
                                 chatMedia: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseChatFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        ChatFormLoaded loaded = ChatFormLoaded(value: await chatRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseChatFormNoLoadEvent) {
        ChatFormLoaded loaded = ChatFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is ChatFormInitialized) {
      ChatModel? newValue = null;
      if (event is ChangedChatDocumentID) {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableChatForm(value: newValue);
        }

        return;
      }
      if (event is ChangedChatAuthorId) {
        newValue = currentState.value!.copyWith(authorId: event.value);
        yield SubmittableChatForm(value: newValue);

        return;
      }
      if (event is ChangedChatAppId) {
        newValue = currentState.value!.copyWith(appId: event.value);
        yield SubmittableChatForm(value: newValue);

        return;
      }
      if (event is ChangedChatRoomId) {
        newValue = currentState.value!.copyWith(roomId: event.value);
        yield SubmittableChatForm(value: newValue);

        return;
      }
      if (event is ChangedChatTimestamp) {
        newValue = currentState.value!.copyWith(timestamp: event.value);
        yield SubmittableChatForm(value: newValue);

        return;
      }
      if (event is ChangedChatSaying) {
        newValue = currentState.value!.copyWith(saying: event.value);
        yield SubmittableChatForm(value: newValue);

        return;
      }
      if (event is ChangedChatChatMedia) {
        newValue = currentState.value!.copyWith(chatMedia: event.value);
        yield SubmittableChatForm(value: newValue);

        return;
      }
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

