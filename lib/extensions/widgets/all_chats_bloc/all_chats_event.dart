import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

import 'all_chats_state.dart';

abstract class AllChatsEvent extends Equatable {
  const AllChatsEvent();
  @override
  List<Object?> get props => [];
}

class LoadAllChats extends AllChatsEvent {}

class NewPage extends AllChatsEvent {}

class AddAllChats extends AllChatsEvent {
  final RoomModel? value;

  const AddAllChats({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'AddAllChats{ value: $value }';
}

class UpdateAllChats extends AllChatsEvent {
  final RoomModel? value;

  const UpdateAllChats({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'UpdateAllChats{ value: $value }';
}

class BlockMember extends AllChatsEvent {
  final String memberId;

  const BlockMember({required this.memberId});

  @override
  List<Object?> get props => [memberId];

  @override
  String toString() => 'BlockMember{ value: $memberId }';
}

class DeleteAllChats extends AllChatsEvent {
  final RoomModel? value;

  const DeleteAllChats({this.value});

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'DeleteAllChats{ value: $value }';
}

class AllChatsUpdated extends AllChatsEvent {
  final List<EnhancedRoomModel> value;
  final bool? mightHaveMore;

  const AllChatsUpdated({required this.value, this.mightHaveMore});

  @override
  List<Object?> get props => [value, mightHaveMore];

  @override
  String toString() =>
      'AllChatsUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

class SelectChat extends AllChatsEvent {
  final RoomModel selected;

  const SelectChat({required this.selected});

  @override
  List<Object?> get props => [selected];

  @override
  String toString() => 'SelectChat{ selected: $selected }';
}

class NewLastReadEvent extends AllChatsEvent {
  final String appId;
  final String roomId;
  final String memberId;
  final DateTime lastRead;

  const NewLastReadEvent(this.appId, this.roomId, this.memberId, this.lastRead);
}
