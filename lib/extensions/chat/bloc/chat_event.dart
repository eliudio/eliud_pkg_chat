import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatFetched extends ChatEvent {
  ChatFetched();
}

class DeleteChat extends ChatEvent {
  final ChatModel? value;

  DeleteChat({ this.value });

  @override
  List<Object?> get props => [ value ];
}

class AddChat extends ChatEvent {
  final String saying;

  AddChat({ required this.saying });

  @override
  List<Object?> get props => [ saying ];
}

class UpdateChat extends ChatEvent {
  final ChatModel value;
  final String newSaying;

  UpdateChat({ required this.value, required this.newSaying });

  @override
  List<Object?> get props => [ value, newSaying ];
}
