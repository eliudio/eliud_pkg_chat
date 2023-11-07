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

import 'package:eliud_pkg_chat/model/chat_member_info_repository.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_event.dart';
import 'package:eliud_pkg_chat/model/chat_member_info_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';

import 'chat_member_info_model.dart';

typedef FilterChatMemberInfoModels = List<ChatMemberInfoModel?> Function(
    List<ChatMemberInfoModel?> values);

class ChatMemberInfoListBloc
    extends Bloc<ChatMemberInfoListEvent, ChatMemberInfoListState> {
  final FilterChatMemberInfoModels? filter;
  final ChatMemberInfoRepository _chatMemberInfoRepository;
  StreamSubscription? _chatMemberInfosListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int chatMemberInfoLimit;

  ChatMemberInfoListBloc(
      {this.filter,
      this.paged,
      this.orderBy,
      this.descending,
      this.detailed,
      this.eliudQuery,
      required ChatMemberInfoRepository chatMemberInfoRepository,
      this.chatMemberInfoLimit = 5})
      : _chatMemberInfoRepository = chatMemberInfoRepository,
        super(ChatMemberInfoListLoading()) {
    on<LoadChatMemberInfoList>((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatMemberInfoListToState();
      } else {
        _mapLoadChatMemberInfoListWithDetailsToState();
      }
    });

    on<NewPage>((event, emit) {
      pages = pages +
          1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadChatMemberInfoListWithDetailsToState();
    });

    on<ChatMemberInfoChangeQuery>((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadChatMemberInfoListToState();
      } else {
        _mapLoadChatMemberInfoListWithDetailsToState();
      }
    });

    on<AddChatMemberInfoList>((event, emit) async {
      await _mapAddChatMemberInfoListToState(event);
    });

    on<UpdateChatMemberInfoList>((event, emit) async {
      await _mapUpdateChatMemberInfoListToState(event);
    });

    on<DeleteChatMemberInfoList>((event, emit) async {
      await _mapDeleteChatMemberInfoListToState(event);
    });

    on<ChatMemberInfoListUpdated>((event, emit) {
      emit(_mapChatMemberInfoListUpdatedToState(event));
    });
  }

  List<ChatMemberInfoModel?> _filter(List<ChatMemberInfoModel?> original) {
    if (filter != null) {
      return filter!(original);
    } else {
      return original;
    }
  }

  Future<void> _mapLoadChatMemberInfoListToState() async {
    int amountNow = (state is ChatMemberInfoListLoaded)
        ? (state as ChatMemberInfoListLoaded).values!.length
        : 0;
    _chatMemberInfosListSubscription?.cancel();
    _chatMemberInfosListSubscription = _chatMemberInfoRepository.listen(
        (list) => add(ChatMemberInfoListUpdated(
            value: _filter(list), mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit:
            ((paged != null) && paged!) ? pages * chatMemberInfoLimit : null);
  }

  Future<void> _mapLoadChatMemberInfoListWithDetailsToState() async {
    int amountNow = (state is ChatMemberInfoListLoaded)
        ? (state as ChatMemberInfoListLoaded).values!.length
        : 0;
    _chatMemberInfosListSubscription?.cancel();
    _chatMemberInfosListSubscription =
        _chatMemberInfoRepository.listenWithDetails(
            (list) => add(ChatMemberInfoListUpdated(
                value: _filter(list), mightHaveMore: amountNow != list.length)),
            orderBy: orderBy,
            descending: descending,
            eliudQuery: eliudQuery,
            limit: ((paged != null) && paged!)
                ? pages * chatMemberInfoLimit
                : null);
  }

  Future<void> _mapAddChatMemberInfoListToState(
      AddChatMemberInfoList event) async {
    var value = event.value;
    if (value != null) {
      await _chatMemberInfoRepository.add(value);
    }
  }

  Future<void> _mapUpdateChatMemberInfoListToState(
      UpdateChatMemberInfoList event) async {
    var value = event.value;
    if (value != null) {
      await _chatMemberInfoRepository.update(value);
    }
  }

  Future<void> _mapDeleteChatMemberInfoListToState(
      DeleteChatMemberInfoList event) async {
    var value = event.value;
    if (value != null) {
      await _chatMemberInfoRepository.delete(value);
    }
  }

  ChatMemberInfoListLoaded _mapChatMemberInfoListUpdatedToState(
          ChatMemberInfoListUpdated event) =>
      ChatMemberInfoListLoaded(
          values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _chatMemberInfosListSubscription?.cancel();
    return super.close();
  }
}
