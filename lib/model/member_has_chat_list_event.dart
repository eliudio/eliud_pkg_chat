/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_model.dart';

abstract class MemberHasChatListEvent extends Equatable {
  const MemberHasChatListEvent();
  @override
  List<Object?> get props => [];
}

class LoadMemberHasChatList extends MemberHasChatListEvent {}

class NewPage extends MemberHasChatListEvent {}

class AddMemberHasChatList extends MemberHasChatListEvent {
  final MemberHasChatModel? value;

  const AddMemberHasChatList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'AddMemberHasChatList{ value: $value }';
}

class UpdateMemberHasChatList extends MemberHasChatListEvent {
  final MemberHasChatModel? value;

  const UpdateMemberHasChatList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'UpdateMemberHasChatList{ value: $value }';
}

class DeleteMemberHasChatList extends MemberHasChatListEvent {
  final MemberHasChatModel? value;

  const DeleteMemberHasChatList({ this.value });

  @override
  List<Object?> get props => [ value ];

  @override
  String toString() => 'DeleteMemberHasChatList{ value: $value }';
}

class MemberHasChatListUpdated extends MemberHasChatListEvent {
  final List<MemberHasChatModel?>? value;
  final bool? mightHaveMore;

  const MemberHasChatListUpdated({ this.value, this.mightHaveMore });

  @override
  List<Object?> get props => [ value, mightHaveMore ];

  @override
  String toString() => 'MemberHasChatListUpdated{ value: $value, mightHaveMore: $mightHaveMore }';
}

class MemberHasChatChangeQuery extends MemberHasChatListEvent {
  final EliudQuery newQuery;

  const MemberHasChatChangeQuery({ required this.newQuery });

  @override
  List<Object?> get props => [ newQuery ];

  @override
  String toString() => 'MemberHasChatChangeQuery{ value: $newQuery }';
}

