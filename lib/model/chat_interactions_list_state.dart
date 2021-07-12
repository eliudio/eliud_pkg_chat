/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_interactions_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/chat_interactions_model.dart';

abstract class ChatInteractionsListState extends Equatable {
  const ChatInteractionsListState();

  @override
  List<Object?> get props => [];
}

class ChatInteractionsListLoading extends ChatInteractionsListState {}

class ChatInteractionsListLoaded extends ChatInteractionsListState {
  final List<ChatInteractionsModel?>? values;
  final bool? mightHaveMore;

  const ChatInteractionsListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'ChatInteractionsListLoaded { values: $values }';
}

class ChatInteractionsNotLoaded extends ChatInteractionsListState {}

