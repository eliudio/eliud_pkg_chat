/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_model.dart';

abstract class MemberHasChatListState extends Equatable {
  const MemberHasChatListState();

  @override
  List<Object?> get props => [];
}

class MemberHasChatListLoading extends MemberHasChatListState {}

class MemberHasChatListLoaded extends MemberHasChatListState {
  final List<MemberHasChatModel?>? values;
  final bool? mightHaveMore;

  const MemberHasChatListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'MemberHasChatListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is MemberHasChatListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;

  @override
  int get hashCode => values.hashCode ^ mightHaveMore.hashCode;
}

class MemberHasChatNotLoaded extends MemberHasChatListState {}

