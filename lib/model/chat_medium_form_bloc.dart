/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_form_bloc.dart
                       
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

import 'package:eliud_pkg_chat/model/chat_medium_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_state.dart';
import 'package:eliud_pkg_chat/model/chat_medium_repository.dart';

class ChatMediumFormBloc extends Bloc<ChatMediumFormEvent, ChatMediumFormState> {
  final String? appId;

  ChatMediumFormBloc(this.appId, ): super(ChatMediumFormUninitialized());
  @override
  Stream<ChatMediumFormState> mapEventToState(ChatMediumFormEvent event) async* {
    final currentState = state;
    if (currentState is ChatMediumFormUninitialized) {
      if (event is InitialiseNewChatMediumFormEvent) {
        ChatMediumFormLoaded loaded = ChatMediumFormLoaded(value: ChatMediumModel(
                                               documentID: "IDENTIFIER", 

        ));
        yield loaded;
        return;

      }


      if (event is InitialiseChatMediumFormEvent) {
        ChatMediumFormLoaded loaded = ChatMediumFormLoaded(value: event.value);
        yield loaded;
        return;
      } else if (event is InitialiseChatMediumFormNoLoadEvent) {
        ChatMediumFormLoaded loaded = ChatMediumFormLoaded(value: event.value);
        yield loaded;
        return;
      }
    } else if (currentState is ChatMediumFormInitialized) {
      ChatMediumModel? newValue = null;
      if (event is ChangedChatMediumMemberMedium) {
        if (event.value != null)
          newValue = currentState.value!.copyWith(memberMedium: await memberMediumRepository(appId: appId)!.get(event.value));
        else
          newValue = new ChatMediumModel(
                                 documentID: currentState.value!.documentID,
                                 memberMedium: null,
          );
        yield SubmittableChatMediumForm(value: newValue);

        return;
      }
    }
  }


}

