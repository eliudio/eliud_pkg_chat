import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object?> get props => [];
}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final RoomModel room;
  final List<ChatModel?> values;
  final bool? mightHaveMore;

  const ChatListLoaded({required this.room, this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'ChatListLoaded { values: $values }';
}

class ChatNotLoaded extends ChatListState {}

