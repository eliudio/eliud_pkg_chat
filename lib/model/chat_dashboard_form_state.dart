/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'chat_dashboard_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatDashboardFormState extends Equatable {
  const ChatDashboardFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ChatDashboardFormUninitialized extends ChatDashboardFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''ChatDashboardFormState()''';
  }
}

// ChatDashboardModel has been initialised and hence ChatDashboardModel is available
class ChatDashboardFormInitialized extends ChatDashboardFormState {
  final ChatDashboardModel? value;

  @override
  List<Object?> get props => [value];

  const ChatDashboardFormInitialized({this.value});
}

// Menu has been initialised and hence a menu is available
abstract class ChatDashboardFormError extends ChatDashboardFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [message, value];

  const ChatDashboardFormError({this.message, super.value});

  @override
  String toString() {
    return '''ChatDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class DocumentIDChatDashboardFormError extends ChatDashboardFormError {
  const DocumentIDChatDashboardFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''DocumentIDChatDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class AppIdChatDashboardFormError extends ChatDashboardFormError {
  const AppIdChatDashboardFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''AppIdChatDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class DescriptionChatDashboardFormError extends ChatDashboardFormError {
  const DescriptionChatDashboardFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''DescriptionChatDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class ConditionsChatDashboardFormError extends ChatDashboardFormError {
  const ConditionsChatDashboardFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''ConditionsChatDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class MembersTypeChatDashboardFormError extends ChatDashboardFormError {
  const MembersTypeChatDashboardFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''MembersTypeChatDashboardFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class ChatDashboardFormLoaded extends ChatDashboardFormInitialized {
  const ChatDashboardFormLoaded({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''ChatDashboardFormLoaded {
      value: $value,
    }''';
  }
}

class SubmittableChatDashboardForm extends ChatDashboardFormInitialized {
  const SubmittableChatDashboardForm({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''SubmittableChatDashboardForm {
      value: $value,
    }''';
  }
}
