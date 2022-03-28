/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/room_model.dart';

abstract class RoomListState extends Equatable {
  const RoomListState();

  @override
  List<Object?> get props => [];
}

class RoomListLoading extends RoomListState {}

class RoomListLoaded extends RoomListState {
  final List<RoomModel?>? values;
  final bool? mightHaveMore;

  const RoomListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'RoomListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is RoomListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;
}

class RoomNotLoaded extends RoomListState {}

