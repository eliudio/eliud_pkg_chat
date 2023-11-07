/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'chat_medium_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatMediumFormState extends Equatable {
  const ChatMediumFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ChatMediumFormUninitialized extends ChatMediumFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''ChatMediumFormState()''';
  }
}

// ChatMediumModel has been initialised and hence ChatMediumModel is available
class ChatMediumFormInitialized extends ChatMediumFormState {
  final ChatMediumModel? value;

  @override
  List<Object?> get props => [value];

  const ChatMediumFormInitialized({this.value});
}

// Menu has been initialised and hence a menu is available
abstract class ChatMediumFormError extends ChatMediumFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [message, value];

  const ChatMediumFormError({this.message, super.value});

  @override
  String toString() {
    return '''ChatMediumFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class DocumentIDChatMediumFormError extends ChatMediumFormError {
  const DocumentIDChatMediumFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''DocumentIDChatMediumFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class MemberMediumChatMediumFormError extends ChatMediumFormError {
  const MemberMediumChatMediumFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''MemberMediumChatMediumFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class ChatMediumFormLoaded extends ChatMediumFormInitialized {
  const ChatMediumFormLoaded({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''ChatMediumFormLoaded {
      value: $value,
    }''';
  }
}

class SubmittableChatMediumForm extends ChatMediumFormInitialized {
  const SubmittableChatMediumForm({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''SubmittableChatMediumForm {
      value: $value,
    }''';
  }
}
