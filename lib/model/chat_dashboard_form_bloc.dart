/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_form_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:eliud_core/tools/enums.dart';

import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_dashboard_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_form_state.dart';

class ChatDashboardFormBloc
    extends Bloc<ChatDashboardFormEvent, ChatDashboardFormState> {
  final FormAction? formAction;
  final String? appId;

  ChatDashboardFormBloc(this.appId, {this.formAction})
      : super(ChatDashboardFormUninitialized()) {
    on<InitialiseNewChatDashboardFormEvent>((event, emit) {
      ChatDashboardFormLoaded loaded = ChatDashboardFormLoaded(
          value: ChatDashboardModel(
        documentID: "",
        appId: "",
        description: "",
      ));
      emit(loaded);
    });

    on<InitialiseChatDashboardFormEvent>((event, emit) async {
      // Need to re-retrieve the document from the repository so that I get all associated types
      ChatDashboardFormLoaded loaded = ChatDashboardFormLoaded(
          value: await chatDashboardRepository(appId: appId)!
              .get(event.value!.documentID));
      emit(loaded);
    });
    on<InitialiseChatDashboardFormNoLoadEvent>((event, emit) async {
      ChatDashboardFormLoaded loaded =
          ChatDashboardFormLoaded(value: event.value);
      emit(loaded);
    });
    ChatDashboardModel? newValue;
    on<ChangedChatDashboardDocumentID>((event, emit) async {
      if (state is ChatDashboardFormInitialized) {
        final currentState = state as ChatDashboardFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.addAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableChatDashboardForm(value: newValue));
        }
      }
    });
    on<ChangedChatDashboardAppId>((event, emit) async {
      if (state is ChatDashboardFormInitialized) {
        final currentState = state as ChatDashboardFormInitialized;
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableChatDashboardForm(value: newValue));
      }
    });
    on<ChangedChatDashboardDescription>((event, emit) async {
      if (state is ChatDashboardFormInitialized) {
        final currentState = state as ChatDashboardFormInitialized;
        newValue = currentState.value!.copyWith(description: event.value);
        emit(SubmittableChatDashboardForm(value: newValue));
      }
    });
    on<ChangedChatDashboardConditions>((event, emit) async {
      if (state is ChatDashboardFormInitialized) {
        final currentState = state as ChatDashboardFormInitialized;
        newValue = currentState.value!.copyWith(conditions: event.value);
        emit(SubmittableChatDashboardForm(value: newValue));
      }
    });
    on<ChangedChatDashboardMembersType>((event, emit) async {
      if (state is ChatDashboardFormInitialized) {
        final currentState = state as ChatDashboardFormInitialized;
        newValue = currentState.value!.copyWith(membersType: event.value);
        emit(SubmittableChatDashboardForm(value: newValue));
      }
    });
  }

  DocumentIDChatDashboardFormError error(
          String message, ChatDashboardModel newValue) =>
      DocumentIDChatDashboardFormError(message: message, value: newValue);

  Future<ChatDashboardFormState> _isDocumentIDValid(
      String? value, ChatDashboardModel newValue) async {
    if (value == null) {
      return Future.value(error("Provide value for documentID", newValue));
    }
    if (value.isEmpty) {
      return Future.value(error("Provide value for documentID", newValue));
    }
    Future<ChatDashboardModel?> findDocument =
        chatDashboardRepository(appId: appId)!.get(value);
    return await findDocument.then((documentFound) {
      if (documentFound == null) {
        return SubmittableChatDashboardForm(value: newValue);
      } else {
        return error("Invalid documentID: already exists", newValue);
      }
    });
  }
}
