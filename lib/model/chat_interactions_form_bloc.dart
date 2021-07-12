/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_form_bloc.dart
                       
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

import 'package:eliud_pkg_chat/model/chat_interactions_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_form_state.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_repository.dart';

class ChatInteractionsFormBloc extends Bloc<ChatInteractionsFormEvent, ChatInteractionsFormState> {
  final FormAction? formAction;
  final String? appId;

  ChatInteractionsFormBloc(this.appId, { this.formAction }): super(ChatInteractionsFormUninitialized());
  @override
  Stream<ChatInteractionsFormState> mapEventToState(ChatInteractionsFormEvent event) async* {
    final currentState = state;
    if (currentState is ChatInteractionsFormUninitialized) {
      if (event is InitialiseNewChatInteractionsFormEvent) {
        ChatInteractionsFormLoaded loaded = ChatInteractionsFormLoaded(value: ChatInteractionsModel(
                                               documentID: "",
                                 authorId: "",
                                 appId: "",
                                 details: "",
                                 readAccess: [],

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseChatInteractionsFormEvent) {
        // Need to re-retrieve the document from the repository so that I get all associated types
        ChatInteractionsFormLoaded loaded = ChatInteractionsFormLoaded(value: await chatInteractionsRepository(appId: appId)!.get(event.value!.documentID));
        yield loaded;
        return;
      } else if (event is InitialiseChatInteractionsFormNoLoadEvent) {
        ChatInteractionsFormLoaded loaded = ChatInteractionsFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is ChatInteractionsFormInitialized) {
      ChatInteractionsModel? newValue = null;
      if (event is ChangedChatInteractionsDocumentID) {
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          yield* _isDocumentIDValid(event.value, newValue).asStream();
        } else {
          yield SubmittableChatInteractionsForm(value: newValue);
        }

        return;
      }
      if (event is ChangedChatInteractionsAuthorId) {
        newValue = currentState.value!.copyWith(authorId: event.value);
        yield SubmittableChatInteractionsForm(value: newValue);

        return;
      }
      if (event is ChangedChatInteractionsAppId) {
        newValue = currentState.value!.copyWith(appId: event.value);
        yield SubmittableChatInteractionsForm(value: newValue);

        return;
      }
      if (event is ChangedChatInteractionsDetails) {
        newValue = currentState.value!.copyWith(details: event.value);
        yield SubmittableChatInteractionsForm(value: newValue);

        return;
      }
    }
  }


  DocumentIDChatInteractionsFormError error(String message, ChatInteractionsModel newValue) => DocumentIDChatInteractionsFormError(message: message, value: newValue);

  Future<ChatInteractionsFormState> _isDocumentIDValid(String? value, ChatInteractionsModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.length == 0) return Future.value(error("Provide value for documentID", newValue));
    Future<ChatInteractionsModel?> findDocument = chatInteractionsRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableChatInteractionsForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }


}

