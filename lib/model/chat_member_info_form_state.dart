/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'chat_member_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatMemberInfoFormState extends Equatable {
  const ChatMemberInfoFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class ChatMemberInfoFormUninitialized extends ChatMemberInfoFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''ChatMemberInfoFormState()''';
  }
}

// ChatMemberInfoModel has been initialised and hence ChatMemberInfoModel is available
class ChatMemberInfoFormInitialized extends ChatMemberInfoFormState {
  final ChatMemberInfoModel? value;

  @override
  List<Object?> get props => [ value ];

  const ChatMemberInfoFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class ChatMemberInfoFormError extends ChatMemberInfoFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const ChatMemberInfoFormError({this.message, ChatMemberInfoModel? value }) : super(value: value);

  @override
  String toString() {
    return '''ChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const DocumentIDChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AuthorIdChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const AuthorIdChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AuthorIdChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const AppIdChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class RoomIdChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const RoomIdChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''RoomIdChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class TimestampChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const TimestampChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''TimestampChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AccessibleByGroupChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const AccessibleByGroupChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AccessibleByGroupChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AccessibleByMembersChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const AccessibleByMembersChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AccessibleByMembersChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ReadAccessChatMemberInfoFormError extends ChatMemberInfoFormError { 
  const ReadAccessChatMemberInfoFormError({ String? message, ChatMemberInfoModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''ReadAccessChatMemberInfoFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class ChatMemberInfoFormLoaded extends ChatMemberInfoFormInitialized { 
  const ChatMemberInfoFormLoaded({ ChatMemberInfoModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''ChatMemberInfoFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableChatMemberInfoForm extends ChatMemberInfoFormInitialized { 
  const SubmittableChatMemberInfoForm({ ChatMemberInfoModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableChatMemberInfoForm {
      value: $value,
    }''';
  }
}


