/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 chat_member_info_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_chat/model/chat_member_info_repository.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';



class ChatMemberInfoListBloc extends Bloc<ChatMemberInfoListEvent, ChatMemberInfoListState> {
  final ChatMemberInfoRepository _chatMemberInfoRepository;
  StreamSubscription? _chatMemberInfosListSubscription;
  final EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatMemberInfoLimit;

  ChatMemberInfoListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, required ChatMemberInfoRepository chatMemberInfoRepository, this.chatMemberInfoLimit = 5})
      : assert(chatMemberInfoRepository != null),
        _chatMemberInfoRepository = chatMemberInfoRepository,
        super(ChatMemberInfoListLoading());

  Stream<ChatMemberInfoListState> _mapLoadChatMemberInfoListToState() async* {
    int amountNow =  (state is ChatMemberInfoListLoaded) ? (state as ChatMemberInfoListLoaded).values!.length : 0;
    _chatMemberInfosListSubscription?.cancel();
    _chatMemberInfosListSubscription = _chatMemberInfoRepository.listen(
          (list) => add(ChatMemberInfoListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && paged!) ? pages * chatMemberInfoLimit : null
    );
  }

  Stream<ChatMemberInfoListState> _mapLoadChatMemberInfoListWithDetailsToState() async* {
    int amountNow =  (state is ChatMemberInfoListLoaded) ? (state as ChatMemberInfoListLoaded).values!.length : 0;
    _chatMemberInfosListSubscription?.cancel();
    _chatMemberInfosListSubscription = _chatMemberInfoRepository.listenWithDetails(
            (list) => add(ChatMemberInfoListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && paged!) ? pages * chatMemberInfoLimit : null
    );
  }

  Stream<ChatMemberInfoListState> _mapAddChatMemberInfoListToState(AddChatMemberInfoList event) async* {
    var value = event.value;
    if (value != null) 
      _chatMemberInfoRepository.add(value);
  }

  Stream<ChatMemberInfoListState> _mapUpdateChatMemberInfoListToState(UpdateChatMemberInfoList event) async* {
    var value = event.value;
    if (value != null) 
      _chatMemberInfoRepository.update(value);
  }

  Stream<ChatMemberInfoListState> _mapDeleteChatMemberInfoListToState(DeleteChatMemberInfoList event) async* {
    var value = event.value;
    if (value != null) 
      _chatMemberInfoRepository.delete(value);
  }

  Stream<ChatMemberInfoListState> _mapChatMemberInfoListUpdatedToState(
      ChatMemberInfoListUpdated event) async* {
    yield ChatMemberInfoListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<ChatMemberInfoListState> mapEventToState(ChatMemberInfoListEvent event) async* {
    if (event is LoadChatMemberInfoList) {
      if ((detailed == null) || (!detailed!)) {
        yield* _mapLoadChatMemberInfoListToState();
      } else {
        yield* _mapLoadChatMemberInfoListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadChatMemberInfoListWithDetailsToState();
    } else if (event is AddChatMemberInfoList) {
      yield* _mapAddChatMemberInfoListToState(event);
    } else if (event is UpdateChatMemberInfoList) {
      yield* _mapUpdateChatMemberInfoListToState(event);
    } else if (event is DeleteChatMemberInfoList) {
      yield* _mapDeleteChatMemberInfoListToState(event);
    } else if (event is ChatMemberInfoListUpdated) {
      yield* _mapChatMemberInfoListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _chatMemberInfosListSubscription?.cancel();
    return super.close();
  }
}


