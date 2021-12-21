import 'package:eliud_pkg_chat/model/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AllChatsState extends Equatable {
  const AllChatsState();

  @override
  List<Object?> get props => [];
}

class AllChatsLoading extends AllChatsState {}

class EnhancedRoomModel {
  final RoomModel roomModel;
  final DateTime? timeStampThisMemberRead;
  final List<OtherMemberRoomInfo> otherMembersRoomInfo;

  EnhancedRoomModel(this.roomModel, this.timeStampThisMemberRead, this.otherMembersRoomInfo);

  @override
  List<Object?> get props => [ roomModel, timeStampThisMemberRead, otherMembersRoomInfo ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is EnhancedRoomModel &&
              roomModel == other.roomModel &&
              timeStampThisMemberRead == other.timeStampThisMemberRead;
}

class AllChatsLoaded extends AllChatsState {
  final List<EnhancedRoomModel>? values;
  final RoomModel? currentRoom;
  final bool? mightHaveMore;

  const AllChatsLoaded({this.mightHaveMore, required this.currentRoom, required this.values});

  @override
  List<Object?> get props => [ currentRoom, values, mightHaveMore ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is AllChatsLoaded &&
              currentRoom == other.currentRoom &&
              mightHaveMore == other.mightHaveMore &&
              const ListEquality().equals(values, other.values);

  @override
  String toString() => 'AllChatsLoaded { values: $values }';
}

class AllChatsNotLoaded extends AllChatsState {}

class OtherMemberRoomInfo {
  final String name;
  final String? avatar;

  OtherMemberRoomInfo({required this.name, required this.avatar});
}

