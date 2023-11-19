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
import 'package:eliud_core_model/tools/query/query_tools.dart';

import 'member_has_chat_model.dart';

typedef List<MemberHasChatModel?> FilterMemberHasChatModels(List<MemberHasChatModel?> values);



class MemberHasChatListBloc extends Bloc<MemberHasChatListEvent, MemberHasChatListState> {
  final FilterMemberHasChatModels? filter;
  final MemberHasChatRepository _memberHasChatRepository;
  StreamSubscription? _memberHasChatsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int memberHasChatLimit;

  MemberHasChatListBloc({this.filter, this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required MemberHasChatRepository memberHasChatRepository, this.memberHasChatLimit = 5})
      : assert(memberHasChatRepository != null),
        _memberHasChatRepository = memberHasChatRepository,
        super(MemberHasChatListLoading()) {
    on <LoadMemberHasChatList> ((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadMemberHasChatListToState();
      } else {
        _mapLoadMemberHasChatListWithDetailsToState();
      }
    });
    
    on <NewPage> ((event, emit) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadMemberHasChatListWithDetailsToState();
    });
    
    on <MemberHasChatChangeQuery> ((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadMemberHasChatListToState();
      } else {
        _mapLoadMemberHasChatListWithDetailsToState();
      }
    });
      
    on <AddMemberHasChatList> ((event, emit) async {
      await _mapAddMemberHasChatListToState(event);
    });
    
    on <UpdateMemberHasChatList> ((event, emit) async {
      await _mapUpdateMemberHasChatListToState(event);
    });
    
    on <DeleteMemberHasChatList> ((event, emit) async {
      await _mapDeleteMemberHasChatListToState(event);
    });
    
    on <MemberHasChatListUpdated> ((event, emit) {
      emit(_mapMemberHasChatListUpdatedToState(event));
    });
  }

  List<MemberHasChatModel?> _filter(List<MemberHasChatModel?> original) {
    if (filter != null) {
      return filter!(original);
    } else {
      return original;
    }
  }

  Future<void> _mapLoadMemberHasChatListToState() async {
    int amountNow =  (state is MemberHasChatListLoaded) ? (state as MemberHasChatListLoaded).values!.length : 0;
    _memberHasChatsListSubscription?.cancel();
    _memberHasChatsListSubscription = _memberHasChatRepository.listen(
          (list) => add(MemberHasChatListUpdated(value: _filter(list), mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * memberHasChatLimit : null
    );
  }

  Future<void> _mapLoadMemberHasChatListWithDetailsToState() async {
    int amountNow =  (state is MemberHasChatListLoaded) ? (state as MemberHasChatListLoaded).values!.length : 0;
    _memberHasChatsListSubscription?.cancel();
    _memberHasChatsListSubscription = _memberHasChatRepository.listenWithDetails(
            (list) => add(MemberHasChatListUpdated(value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * memberHasChatLimit : null
    );
  }

  Future<void> _mapAddMemberHasChatListToState(AddMemberHasChatList event) async {
    var value = event.value;
    if (value != null) {
      await _memberHasChatRepository.add(value);
    }
  }

  Future<void> _mapUpdateMemberHasChatListToState(UpdateMemberHasChatList event) async {
    var value = event.value;
    if (value != null) {
      await _memberHasChatRepository.update(value);
    }
  }

  Future<void> _mapDeleteMemberHasChatListToState(DeleteMemberHasChatList event) async {
    var value = event.value;
    if (value != null) {
      await _memberHasChatRepository.delete(value);
    }
  }

  MemberHasChatListLoaded _mapMemberHasChatListUpdatedToState(
      MemberHasChatListUpdated event) => MemberHasChatListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _memberHasChatsListSubscription?.cancel();
    return super.close();
  }
}


