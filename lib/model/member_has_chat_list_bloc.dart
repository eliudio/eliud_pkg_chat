/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_has_chat_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/member_has_chat_repository.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_list_event.dart';
import 'package:eliud_pkg_chat/model/member_has_chat_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class MemberHasChatListBloc extends Bloc<MemberHasChatListEvent, MemberHasChatListState> {
  final MemberHasChatRepository _memberHasChatRepository;
  StreamSubscription? _memberHasChatsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int memberHasChatLimit;

  MemberHasChatListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required MemberHasChatRepository memberHasChatRepository, this.memberHasChatLimit = 5})
      : assert(memberHasChatRepository != null),
        _memberHasChatRepository = memberHasChatRepository,
        super(MemberHasChatListLoading());

  Stream<MemberHasChatListState> _mapLoadMemberHasChatListToState() async* {
    int amountNow =  (state is MemberHasChatListLoaded) ? (state as MemberHasChatListLoaded).values!.length : 0;
    _memberHasChatsListSubscription?.cancel();
    _memberHasChatsListSubscription = _memberHasChatRepository.listen(
          (list) => add(MemberHasChatListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * memberHasChatLimit : null
    );
  }

  Stream<MemberHasChatListState> _mapLoadMemberHasChatListWithDetailsToState() async* {
    int amountNow =  (state is MemberHasChatListLoaded) ? (state as MemberHasChatListLoaded).values!.length : 0;
    _memberHasChatsListSubscription?.cancel();
    _memberHasChatsListSubscription = _memberHasChatRepository.listenWithDetails(
            (list) => add(MemberHasChatListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * memberHasChatLimit : null
    );
  }

  Stream<MemberHasChatListState> _mapAddMemberHasChatListToState(AddMemberHasChatList event) async* {
    var value = event.value;
    if (value != null) 
      _memberHasChatRepository.add(value);
  }

  Stream<MemberHasChatListState> _mapUpdateMemberHasChatListToState(UpdateMemberHasChatList event) async* {
    var value = event.value;
    if (value != null) 
      _memberHasChatRepository.update(value);
  }

  Stream<MemberHasChatListState> _mapDeleteMemberHasChatListToState(DeleteMemberHasChatList event) async* {
    var value = event.value;
    if (value != null) 
      _memberHasChatRepository.delete(value);
  }

  Stream<MemberHasChatListState> _mapMemberHasChatListUpdatedToState(
      MemberHasChatListUpdated event) async* {
    yield MemberHasChatListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<MemberHasChatListState> mapEventToState(MemberHasChatListEvent event) async* {
    if (event is LoadMemberHasChatList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadMemberHasChatListToState();
      } else {
        yield* _mapLoadMemberHasChatListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadMemberHasChatListWithDetailsToState();
    } else if (event is AddMemberHasChatList) {
      yield* _mapAddMemberHasChatListToState(event);
    } else if (event is UpdateMemberHasChatList) {
      yield* _mapUpdateMemberHasChatListToState(event);
    } else if (event is DeleteMemberHasChatList) {
      yield* _mapDeleteMemberHasChatListToState(event);
    } else if (event is MemberHasChatListUpdated) {
      yield* _mapMemberHasChatListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _memberHasChatsListSubscription?.cancel();
    return super.close();
  }
}


