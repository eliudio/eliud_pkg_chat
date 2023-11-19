/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'member_has_chat_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MemberHasChatFormState extends Equatable {
  const MemberHasChatFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class MemberHasChatFormUninitialized extends MemberHasChatFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''MemberHasChatFormState()''';
  }
}

// MemberHasChatModel has been initialised and hence MemberHasChatModel is available
class MemberHasChatFormInitialized extends MemberHasChatFormState {
  final MemberHasChatModel? value;

  @override
  List<Object?> get props => [ value ];

  const MemberHasChatFormInitialized({ this.value });
}

// Menu has been initialised and hence a menu is available
abstract class MemberHasChatFormError extends MemberHasChatFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [ message, value ];

  const MemberHasChatFormError({this.message, MemberHasChatModel? value }) : super(value: value);

  @override
  String toString() {
    return '''MemberHasChatFormError {
      value: $value,
      message: $message,
    }''';
  }
}
class DocumentIDMemberHasChatFormError extends MemberHasChatFormError { 
  const DocumentIDMemberHasChatFormError({ String? message, MemberHasChatModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''DocumentIDMemberHasChatFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class MemberIdMemberHasChatFormError extends MemberHasChatFormError { 
  const MemberIdMemberHasChatFormError({ String? message, MemberHasChatModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''MemberIdMemberHasChatFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class AppIdMemberHasChatFormError extends MemberHasChatFormError { 
  const AppIdMemberHasChatFormError({ String? message, MemberHasChatModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''AppIdMemberHasChatFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class HasUnreadMemberHasChatFormError extends MemberHasChatFormError { 
  const HasUnreadMemberHasChatFormError({ String? message, MemberHasChatModel? value }): super(message: message, value: value);

  @override
  List<Object?> get props => [ message, value ];

  @override
  String toString() {
    return '''HasUnreadMemberHasChatFormError {
      value: $value,
      message: $message,
    }''';
  }
}


class MemberHasChatFormLoaded extends MemberHasChatFormInitialized { 
  const MemberHasChatFormLoaded({ MemberHasChatModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''MemberHasChatFormLoaded {
      value: $value,
    }''';
  }
}


class SubmittableMemberHasChatForm extends MemberHasChatFormInitialized { 
  const SubmittableMemberHasChatForm({ MemberHasChatModel? value }): super(value: value);

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() {
    return '''SubmittableMemberHasChatForm {
      value: $value,
    }''';
  }
}


