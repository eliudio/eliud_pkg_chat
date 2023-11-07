/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_form_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RoomFormState extends Equatable {
  const RoomFormState();

  @override
  List<Object?> get props => [];
}

// Startup: menu has not been initialised yet and so we should show a "loading indicator" or something
class RoomFormUninitialized extends RoomFormState {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '''RoomFormState()''';
  }
}

// RoomModel has been initialised and hence RoomModel is available
class RoomFormInitialized extends RoomFormState {
  final RoomModel? value;

  @override
  List<Object?> get props => [value];

  const RoomFormInitialized({this.value});
}

// Menu has been initialised and hence a menu is available
abstract class RoomFormError extends RoomFormInitialized {
  final String? message;

  @override
  List<Object?> get props => [message, value];

  const RoomFormError({this.message, super.value});

  @override
  String toString() {
    return '''RoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class DocumentIDRoomFormError extends RoomFormError {
  const DocumentIDRoomFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''DocumentIDRoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class OwnerIdRoomFormError extends RoomFormError {
  const OwnerIdRoomFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''OwnerIdRoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class AppIdRoomFormError extends RoomFormError {
  const AppIdRoomFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''AppIdRoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class DescriptionRoomFormError extends RoomFormError {
  const DescriptionRoomFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''DescriptionRoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class IsRoomRoomFormError extends RoomFormError {
  const IsRoomRoomFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''IsRoomRoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class MembersRoomFormError extends RoomFormError {
  const MembersRoomFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''MembersRoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class TimestampRoomFormError extends RoomFormError {
  const TimestampRoomFormError({super.message, super.value});

  @override
  List<Object?> get props => [message, value];

  @override
  String toString() {
    return '''TimestampRoomFormError {
      value: $value,
      message: $message,
    }''';
  }
}

class RoomFormLoaded extends RoomFormInitialized {
  const RoomFormLoaded({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''RoomFormLoaded {
      value: $value,
    }''';
  }
}

class SubmittableRoomForm extends RoomFormInitialized {
  const SubmittableRoomForm({super.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() {
    return '''SubmittableRoomForm {
      value: $value,
    }''';
  }
}
