/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_model.dart';

abstract class ChatMemberInfoListState extends Equatable {
  const ChatMemberInfoListState();

  @override
  List<Object?> get props => [];
}

class ChatMemberInfoListLoading extends ChatMemberInfoListState {}

class ChatMemberInfoListLoaded extends ChatMemberInfoListState {
  final List<ChatMemberInfoModel?>? values;
  final bool? mightHaveMore;

  const ChatMemberInfoListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'ChatMemberInfoListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is ChatMemberInfoListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;

  @override
  int get hashCode => values.hashCode ^ mightHaveMore.hashCode;
}

class ChatMemberInfoNotLoaded extends ChatMemberInfoListState {}

