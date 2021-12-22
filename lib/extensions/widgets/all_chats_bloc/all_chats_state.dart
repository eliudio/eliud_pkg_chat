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
  final bool hasUnread;
  final DateTime? otherMemberLastRead;

  EnhancedRoomModel(this.roomModel, this.timeStampThisMemberRead, this.otherMembersRoomInfo, this.otherMemberLastRead) :
    hasUnread = (timeStampThisMemberRead != null) &&
        (roomModel.timestamp!.compareTo(timeStampThisMemberRead) > 0);

  @override
  List<Object?> get props => [ roomModel, timeStampThisMemberRead, otherMembersRoomInfo ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is EnhancedRoomModel &&
              roomModel == other.roomModel &&
              hasUnread == other.hasUnread &&
              otherMemberLastRead == other.otherMemberLastRead &&
              const ListEquality().equals(otherMembersRoomInfo, other.otherMembersRoomInfo) &&
              timeStampThisMemberRead == other.timeStampThisMemberRead;

  EnhancedRoomModel copyWith({RoomModel? roomModel, DateTime? timeStampThisMemberRead, List<OtherMemberRoomInfo>? otherMembersRoomInfo,
    bool? hasUnread, DateTime? otherMemberLastRead}) {
    return EnhancedRoomModel(roomModel ?? this.roomModel,
        timeStampThisMemberRead ?? this.timeStampThisMemberRead,
        otherMembersRoomInfo ?? this.otherMembersRoomInfo,
        otherMemberLastRead ?? this.otherMemberLastRead,
    );
  }
}

class AllChatsLoaded extends AllChatsState {
  final List<EnhancedRoomModel> enhancedRoomModels;
  final RoomModel? currentRoom;
  final bool? mightHaveMore;

  const AllChatsLoaded({this.mightHaveMore, required this.currentRoom, required this.enhancedRoomModels});

  @override
  List<Object?> get props => [ currentRoom, enhancedRoomModels, mightHaveMore ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is AllChatsLoaded &&
              currentRoom == other.currentRoom &&
              mightHaveMore == other.mightHaveMore &&
              const ListEquality().equals(enhancedRoomModels, other.enhancedRoomModels);

  @override
  String toString() => 'AllChatsLoaded { values: $enhancedRoomModels }';
}

class AllChatsNotLoaded extends AllChatsState {}

class OtherMemberRoomInfo {
  final String memberId;
  final String name;
  final String? avatar;

  OtherMemberRoomInfo({required this.memberId, required this.name, required this.avatar});
}

