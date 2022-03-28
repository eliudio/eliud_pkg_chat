/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_dashboard_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_dashboard_model.dart';

abstract class ChatDashboardListState extends Equatable {
  const ChatDashboardListState();

  @override
  List<Object?> get props => [];
}

class ChatDashboardListLoading extends ChatDashboardListState {}

class ChatDashboardListLoaded extends ChatDashboardListState {
  final List<ChatDashboardModel?>? values;
  final bool? mightHaveMore;

  const ChatDashboardListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'ChatDashboardListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is ChatDashboardListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;
}

class ChatDashboardNotLoaded extends ChatDashboardListState {}

