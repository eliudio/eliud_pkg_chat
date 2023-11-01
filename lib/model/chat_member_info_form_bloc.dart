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

import 'package:eliud_core/tools/enums.dart';



import 'package:eliud_pkg_chat/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_member_info_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_form_state.dart';

class ChatMemberInfoFormBloc extends Bloc<ChatMemberInfoFormEvent, ChatMemberInfoFormState> {
  final FormAction? formAction;
  final String? appId;

  ChatMemberInfoFormBloc(this.appId, { this.formAction }): super(ChatMemberInfoFormUninitialized()) {
      on <InitialiseNewChatMemberInfoFormEvent> ((event, emit) {
        ChatMemberInfoFormLoaded loaded = ChatMemberInfoFormLoaded(value: ChatMemberInfoModel(
                                               documentID: "",
                                 authorId: "",
                                 appId: "",
                                 roomId: "",
                                 accessibleByMembers: [],
                                 readAccess: [],

        ));
        emit(loaded);
      });


      on <InitialiseChatMemberInfoFormEvent> ((event, emit) async {
        // Need to re-retrieve the document from the repository so that I get all associated types
        ChatMemberInfoFormLoaded loaded = ChatMemberInfoFormLoaded(value: await chatMemberInfoRepository(appId: appId)!.get(event.value!.documentID));
        emit(loaded);
      });
      on <InitialiseChatMemberInfoFormNoLoadEvent> ((event, emit) async {
        ChatMemberInfoFormLoaded loaded = ChatMemberInfoFormLoaded(value: event.value);
        emit(loaded);
      });
      ChatMemberInfoModel? newValue;
      on <ChangedChatMemberInfoDocumentID> ((event, emit) async {
      if (state is ChatMemberInfoFormInitialized) {
        final currentState = state as ChatMemberInfoFormInitialized;
        newValue = currentState.value!.copyWith(documentID: event.value);
        if (formAction == FormAction.AddAction) {
          emit(await _isDocumentIDValid(event.value, newValue!));
        } else {
          emit(SubmittableChatMemberInfoForm(value: newValue));
        }

      }
      });
      on <ChangedChatMemberInfoAuthorId> ((event, emit) async {
      if (state is ChatMemberInfoFormInitialized) {
        final currentState = state as ChatMemberInfoFormInitialized;
        newValue = currentState.value!.copyWith(authorId: event.value);
        emit(SubmittableChatMemberInfoForm(value: newValue));

      }
      });
      on <ChangedChatMemberInfoAppId> ((event, emit) async {
      if (state is ChatMemberInfoFormInitialized) {
        final currentState = state as ChatMemberInfoFormInitialized;
        newValue = currentState.value!.copyWith(appId: event.value);
        emit(SubmittableChatMemberInfoForm(value: newValue));

      }
      });
      on <ChangedChatMemberInfoRoomId> ((event, emit) async {
      if (state is ChatMemberInfoFormInitialized) {
        final currentState = state as ChatMemberInfoFormInitialized;
        newValue = currentState.value!.copyWith(roomId: event.value);
        emit(SubmittableChatMemberInfoForm(value: newValue));

      }
      });
      on <ChangedChatMemberInfoTimestamp> ((event, emit) async {
      if (state is ChatMemberInfoFormInitialized) {
        final currentState = state as ChatMemberInfoFormInitialized;
        newValue = currentState.value!.copyWith(timestamp: dateTimeFromTimestampString(event.value!));
        emit(SubmittableChatMemberInfoForm(value: newValue));

      }
      });
      on <ChangedChatMemberInfoAccessibleByGroup> ((event, emit) async {
      if (state is ChatMemberInfoFormInitialized) {
        final currentState = state as ChatMemberInfoFormInitialized;
        newValue = currentState.value!.copyWith(accessibleByGroup: event.value);
        emit(SubmittableChatMemberInfoForm(value: newValue));

      }
      });
  }


  DocumentIDChatMemberInfoFormError error(String message, ChatMemberInfoModel newValue) => DocumentIDChatMemberInfoFormError(message: message, value: newValue);

  Future<ChatMemberInfoFormState> _isDocumentIDValid(String? value, ChatMemberInfoModel newValue) async {
    if (value == null) return Future.value(error("Provide value for documentID", newValue));
    if (value.isEmpty) return Future.value(error("Provide value for documentID", newValue));
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

