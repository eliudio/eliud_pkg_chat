/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 room_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_chat/model/room_repository.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'room_model.dart';

typedef FilterRoomModels = List<RoomModel?> Function(List<RoomModel?> values);



class RoomListBloc extends Bloc<RoomListEvent, RoomListState> {
  final FilterRoomModels? filter;
  final RoomRepository _roomRepository;
  StreamSubscription? _roomsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int roomLimit;

  RoomListBloc({this.filter, this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required RoomRepository roomRepository, this.roomLimit = 5})
      : _roomRepository = roomRepository,
        super(RoomListLoading()) {
    on <LoadRoomList> ((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadRoomListToState();
      } else {
        _mapLoadRoomListWithDetailsToState();
      }
    });
    
    on <NewPage> ((event, emit) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadRoomListWithDetailsToState();
    });
    
    on <RoomChangeQuery> ((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadRoomListToState();
      } else {
        _mapLoadRoomListWithDetailsToState();
      }
    });
      
    on <AddRoomList> ((event, emit) async {
      await _mapAddRoomListToState(event);
    });
    
    on <UpdateRoomList> ((event, emit) async {
      await _mapUpdateRoomListToState(event);
    });
    
    on <DeleteRoomList> ((event, emit) async {
      await _mapDeleteRoomListToState(event);
    });
    
    on <RoomListUpdated> ((event, emit) {
      emit(_mapRoomListUpdatedToState(event));
    });
  }

  List<RoomModel?> _filter(List<RoomModel?> original) {
    if (filter != null) {
      return filter!(original);
    } else {
      return original;
    }
  }

  Future<void> _mapLoadRoomListToState() async {
    int amountNow =  (state is RoomListLoaded) ? (state as RoomListLoaded).values!.length : 0;
    _roomsListSubscription?.cancel();
    _roomsListSubscription = _roomRepository.listen(
          (list) => add(RoomListUpdated(value: _filter(list), mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * roomLimit : null
    );
  }

  Future<void> _mapLoadRoomListWithDetailsToState() async {
    int amountNow =  (state is RoomListLoaded) ? (state as RoomListLoaded).values!.length : 0;
    _roomsListSubscription?.cancel();
    _roomsListSubscription = _roomRepository.listenWithDetails(
            (list) => add(RoomListUpdated(value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * roomLimit : null
    );
  }

  Future<void> _mapAddRoomListToState(AddRoomList event) async {
    var value = event.value;
    if (value != null) {
      await _roomRepository.add(value);
    }
  }

  Future<void> _mapUpdateRoomListToState(UpdateRoomList event) async {
    var value = event.value;
    if (value != null) {
      await _roomRepository.update(value);
    }
  }

  Future<void> _mapDeleteRoomListToState(DeleteRoomList event) async {
    var value = event.value;
    if (value != null) {
      await _roomRepository.delete(value);
    }
  }

  RoomListLoaded _mapRoomListUpdatedToState(
      RoomListUpdated event) => RoomListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _roomsListSubscription?.cancel();
    return super.close();
  }
}


