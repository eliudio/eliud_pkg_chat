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
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/room_repository.dart';
import 'package:eliud_pkg_chat/model/room_list_event.dart';
import 'package:eliud_pkg_chat/model/room_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _roomLimit = 5;

class RoomListBloc extends Bloc<RoomListEvent, RoomListState> {
  final RoomRepository _roomRepository;
  StreamSubscription? _roomsListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;

  RoomListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required RoomRepository roomRepository})
      : assert(roomRepository != null),
        _roomRepository = roomRepository,
        super(RoomListLoading());

  Stream<RoomListState> _mapLoadRoomListToState() async* {
    int amountNow =  (state is RoomListLoaded) ? (state as RoomListLoaded).values!.length : 0;
    _roomsListSubscription?.cancel();
    _roomsListSubscription = _roomRepository.listen(
          (list) => add(RoomListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * _roomLimit : null
    );
  }

  Stream<RoomListState> _mapLoadRoomListWithDetailsToState() async* {
    int amountNow =  (state is RoomListLoaded) ? (state as RoomListLoaded).values!.length : 0;
    _roomsListSubscription?.cancel();
    _roomsListSubscription = _roomRepository.listenWithDetails(
            (list) => add(RoomListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * _roomLimit : null
    );
  }

  Stream<RoomListState> _mapAddRoomListToState(AddRoomList event) async* {
    var value = event.value;
    if (value != null) 
      _roomRepository.add(value);
  }

  Stream<RoomListState> _mapUpdateRoomListToState(UpdateRoomList event) async* {
    var value = event.value;
    if (value != null) 
      _roomRepository.update(value);
  }

  Stream<RoomListState> _mapDeleteRoomListToState(DeleteRoomList event) async* {
    var value = event.value;
    if (value != null) 
      _roomRepository.delete(value);
  }

  Stream<RoomListState> _mapRoomListUpdatedToState(
      RoomListUpdated event) async* {
    yield RoomListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<RoomListState> mapEventToState(RoomListEvent event) async* {
    if (event is LoadRoomList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadRoomListToState();
      } else {
        yield* _mapLoadRoomListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadRoomListWithDetailsToState();
    } else if (event is AddRoomList) {
      yield* _mapAddRoomListToState(event);
    } else if (event is UpdateRoomList) {
      yield* _mapUpdateRoomListToState(event);
    } else if (event is DeleteRoomList) {
      yield* _mapDeleteRoomListToState(event);
    } else if (event is RoomListUpdated) {
      yield* _mapRoomListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _roomsListSubscription?.cancel();
    return super.close();
  }
}


