/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'chat_interactions_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatInteractionsFormState extends Equatable {
  const ChatInteractionsFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ChatInteractionsFormUninitialized extends ChatInteractionsFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''ChatInteractionsFormState()''';
  }
}

// ChatInteractionsModel has been initialised and hence ChatInteractionsModel is available
class ChatInteractionsFormInitialized extends ChatInteractionsFormState {
  final ChatInteractionsModel? value;

  @override
  List<Object?> get props => [ value ];

  const ChatInteractionsFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class ChatInteractionsFormError extends ChatInteractionsFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const ChatInteractionsFormError({this.message, ChatInteractionsModel? value }) : super(value: value);

  @override
  String toString() {
    return '''ChatInteractionsFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDChatInteractionsFormError extends ChatInteractionsFormError { 
  const DocumentIDChatInteractionsFormError({ String? message, ChatInteractionsModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDChatInteractionsFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AuthorIdChatInteractionsFormError extends ChatInteractionsFormError { 
  const AuthorIdChatInteractionsFormError({ String? message, ChatInteractionsModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AuthorIdChatInteractionsFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdChatInteractionsFormError extends ChatInteractionsFormError { 
  const AppIdChatInteractionsFormError({ String? message, ChatInteractionsModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdChatInteractionsFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class DetailsChatInteractionsFormError extends ChatInteractionsFormError { 
  const DetailsChatInteractionsFormError({ String? message, ChatInteractionsModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DetailsChatInteractionsFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ReadAccessChatInteractionsFormError extends ChatInteractionsFormError { 
  const ReadAccessChatInteractionsFormError({ String? message, ChatInteractionsModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ReadAccessChatInteractionsFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ChatInteractionsFormLoaded extends ChatInteractionsFormInitialized { 
  const ChatInteractionsFormLoaded({ ChatInteractionsModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''ChatInteractionsFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableChatInteractionsForm extends ChatInteractionsFormInitialized { 
  const SubmittableChatInteractionsForm({ ChatInteractionsModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableChatInteractionsForm {
      value: $value,
    }''';
  }
}


