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

import 'package:eliud_core/tools/enums.dart';



import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_form_state.dart';

class ChatFormBloc extends Bloc<ChatFormEvent, ChatFormState> {
  final FormAction? formAction;
  final String? appId;

  ChatFormBloc(this.appId, { this.formAction }): super(ChatFormUninitialized()) {
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


      on <InitialiseChatFormEvent> ((event, emit) async {
        // Need to re-retrieve the document from the repository so that I get all associated types
        ChatFormLoaded loaded = ChatFormLoaded(value: await chatRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      });
      on <InitialiseChatFormNoLoadEvent> ((event, emit) async {
        ChatFormLoaded loaded = ChatFormLoaded(value: event.value);
        emit(loaded);
      });
      ChatModel? newValue;
      on <ChangedChatDocumentID> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableChatForm(value: newValue));
        }

      }
      });
      on <ChangedChatAuthorId> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(authorId: event.value);
        emit(SubmittableChatForm(value: newValue));

      }
      });
      on <ChangedChatAppId> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableChatForm(value: newValue));

      }
      });
      on <ChangedChatRoomId> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(roomId: event.value);
        emit(SubmittableChatForm(value: newValue));

      }
      });
      on <ChangedChatTimestamp> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(timestamp: dateTimeFromTimestampString(event.value!));
        emit(SubmittableChatForm(value: newValue));

      }
      });
      on <ChangedChatSaying> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(saying: event.value);
        emit(SubmittableChatForm(value: newValue));

      }
      });
      on <ChangedChatAccessibleByGroup> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(accessibleByGroup: event.value);
        emit(SubmittableChatForm(value: newValue));

      }
      });
      on <ChangedChatChatMedia> ((event, emit) async {
      if (state is ChatFormInitialized) {
        final currentState = state as ChatFormInitialized;
        newValue = currentState.value!.copyWith(chatMedia: event.value);
        emit(SubmittableChatForm(value: newValue));

      }
      });
  }


  DocumentIDChatFormError error(String message, ChatModel newValue) => DocumentIDChatFormError(message: message, value: newValue);

  Future<ChatFormState> _isDocumentIDValid(String? value, ChatModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.isEmpty) return Future.value(error("Provide value for documentID", newValue));
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

