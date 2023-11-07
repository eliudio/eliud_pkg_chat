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

import 'package:bloc/bloc.dart';

import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_chat/model/model_export.dart';

import 'package:eliud_pkg_chat/model/chat_medium_form_event.dart';
import 'package:eliud_pkg_chat/model/chat_medium_form_state.dart';

class ChatMediumFormBloc
    extends Bloc<ChatMediumFormEvent, ChatMediumFormState> {
  final String? appId;

  ChatMediumFormBloc(
    this.appId,
  ) : super(ChatMediumFormUninitialized()) {
    on<InitialiseNewChatMediumFormEvent>((event, emit) {
      ChatMediumFormLoaded loaded = ChatMediumFormLoaded(
          value: ChatMediumModel(
        documentID: "IDENTIFIER",
      ));
      emit(loaded);
    });

    on<InitialiseChatMediumFormEvent>((event, emit) async {
      ChatMediumFormLoaded loaded = ChatMediumFormLoaded(value: event.value);
      emit(loaded);
    });
    on<InitialiseChatMediumFormNoLoadEvent>((event, emit) async {
      ChatMediumFormLoaded loaded = ChatMediumFormLoaded(value: event.value);
      emit(loaded);
    });
    ChatMediumModel? newValue;
    on<ChangedChatMediumMemberMedium>((event, emit) async {
      if (state is ChatMediumFormInitialized) {
        final currentState = state as ChatMediumFormInitialized;
        if (event.value != null) {
          newValue = currentState.value!.copyWith(
              memberMedium:
                  await memberMediumRepository(appId: appId)!.get(event.value));
        }
        emit(SubmittableChatMediumForm(value: newValue));
      }
    });
  }
}
