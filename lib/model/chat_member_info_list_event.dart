/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';

abstract class ChatMemberInfoListEvent extends Equatable {
  const ChatMemberInfoListEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatMemberInfoList extends ChatMemberInfoListEvent {}

class NewPage extends ChatMemberInfoListEvent {}

class AddChatMemberInfoList extends ChatMemberInfoListEvent {
  final ChatMemberInfoModel? value;

  const AddChatMemberInfoList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddChatMemberInfoList{ value: $value }';
}

class UpdateChatMemberInfoList extends ChatMemberInfoListEvent {
  final ChatMemberInfoModel? value;

  const UpdateChatMemberInfoList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateChatMemberInfoList{ value: $value }';
}

class DeleteChatMemberInfoList extends ChatMemberInfoListEvent {
  final ChatMemberInfoModel? value;

  const DeleteChatMemberInfoList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteChatMemberInfoList{ value: $value }';
}

class ChatMemberInfoListUpdated extends ChatMemberInfoListEvent {
  final List<ChatMemberInfoModel?>? value;
  final bool? mightHaveMore;

  const ChatMemberInfoListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'ChatMemberInfoListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

