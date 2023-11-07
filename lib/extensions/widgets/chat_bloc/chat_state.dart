import 'package:eliud_pkg_chat/extensions/widgets/all_chats_bloc/all_chats_state.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {}
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

class ChatLoaded extends ChatState {
  final EnhancedRoomModel room;
  final List<ChatModel> values;
  final bool? mightHaveMore;

  const ChatLoaded(
      {required this.room, this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [values, mightHaveMore, room];

  @override
  String toString() => 'ChatLoaded { values: $values }';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatLoaded &&
          room == other.room &&
          mightHaveMore == other.mightHaveMore &&
          const ListEquality().equals(values, other.values);

  ChatLoaded withNewEnhancedRoomModel(EnhancedRoomModel newRoom) {
    return ChatLoaded(
        room: newRoom, mightHaveMore: mightHaveMore, values: values);
  }

  @override
  int get hashCode => room.hashCode ^ mightHaveMore.hashCode ^ values.hashCode;
}

class ChatNotLoaded extends ChatState {}
