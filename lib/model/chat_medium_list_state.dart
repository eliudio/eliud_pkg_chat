/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_medium_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_medium_model.dart';

abstract class ChatMediumListState extends Equatable {
  const ChatMediumListState();

  @override
  List<Object?> get props => [];
}

class ChatMediumListLoading extends ChatMediumListState {}

class ChatMediumListLoaded extends ChatMediumListState {
  final List<ChatMediumModel?>? values;
  final bool? mightHaveMore;

  const ChatMediumListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'ChatMediumListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is ChatMediumListLoaded &&
              runtimeType == other.runtimeType &&
              const ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;
}

class ChatMediumNotLoaded extends ChatMediumListState {}

