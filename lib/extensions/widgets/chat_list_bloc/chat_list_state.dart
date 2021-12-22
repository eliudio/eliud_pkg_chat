import 'package:eliud_pkg_chat/extensions/widgets/all_chats_bloc/all_chats_state.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object?> get props => [];
}

class ChatListLoading extends ChatListState {}
/*

class EnhancedChatModel {
  final ChatModel chatModel;
  final bool hasOtherMemberRead;

  EnhancedChatModel(this.chatModel, this.hasOtherMemberRead);

  @override
  List<Object?> get props => [ chatModel, hasOtherMemberRead ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is EnhancedChatModel &&
              chatModel == other.chatModel &&
              hasOtherMemberRead == other.hasOtherMemberRead;
}
*/

class ChatListLoaded extends ChatListState {
  final EnhancedRoomModel room;
  final List<ChatModel> values;
  final bool? mightHaveMore;

  const ChatListLoaded({required this.room, this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore, room ];

  @override
  String toString() => 'ChatListLoaded { values: $values }';

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ChatListLoaded &&
              room == other.room &&
              mightHaveMore == other.mightHaveMore &&
              const ListEquality().equals(values, other.values);

  ChatListLoaded withNewEnhancedRoomModel(EnhancedRoomModel newRoom) {
    return ChatListLoaded(room: newRoom, mightHaveMore: mightHaveMore, values: values);
  }
}

class ChatNotLoaded extends ChatListState {}
