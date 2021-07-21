import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:eliud_pkg_chat/model/chat_repository.dart';

import 'chat_event.dart';
import 'chat_state.dart';

const _chatLimit = 5;

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String memberId;
  final String appId;
  final String roomId;
  final List<String> readAccess;
  final ChatRepository _chatRepository;
  Object? lastRowFetched;
  EliudQuery eliudQuery;

  ChatBloc(this.memberId, this.appId, this.roomId, this.readAccess, this.eliudQuery,
      {required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(const ChatState());

/*
  @override
  Stream<Transition<PostPagedEvent, PostListPagedState>> transformEvents(
    Stream<PostPagedEvent> events,
    TransitionFunction<PostPagedEvent, PostListPagedState> transitionFn,
  ) {
    return super.transformEvents(
      events,
      transitionFn,
    );
  }
*/

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatFetched) {
      var value = await _mapPostFetchedToState(state);
      if (value != null) yield value;
    } else if (event is UpdateChat) {
      await _mapUpdateChat(event);

      // We update the entry in the current state avoiding interaction with repository
      var newListOfValues = <ChatModel>[];
      state.values.forEach((element) {
        if (element!.documentID != event.value.documentID) {
          newListOfValues.add(element);
        } else {
          newListOfValues.add(element.copyWith(saying: event.newSaying));
        }
      });

      yield state.copyWith(values: newListOfValues);
    } else if (event is AddChat) {
      var newChat = await _mapAddChat(event);
      if (newChat != null) {
        List<ChatModel?> newListOfValues = [];
        newListOfValues.add(newChat!);
        newListOfValues.addAll(state.values);

        yield state.copyWith(values: newListOfValues);
      }
    } else if (event is DeleteChat) {
/*
      await _mapDeleteChat(event);

      // We delete the entry and add it whilst limiting interaction with repository
      var newListOfValues = <PostDetails>[];
      state.values.forEach((element) {
        if (element.postModel.documentID != event.value!.documentID) {
          newListOfValues.add(element);
        }
      });

      final extraValues =
      await _fetchPosts(lastRowFetched: state.lastRowFetched, limit: 1);
      var newState = extraValues.isEmpty
          ? state.copyWith(hasReachedMax: true,
            status: PostListPagedStatus.success,
            values: List.of(newListOfValues),
          )
          : state.copyWith(
        status: PostListPagedStatus.success,
        values: List.of(newListOfValues)..addAll(extraValues),
        lastRowFetched: lastRowFetched,
        hasReachedMax:
        _hasReachedMax(newListOfValues.length + extraValues.length),
      );

      yield newState;
*/
    }
  }

  Future<void> _mapDeleteChat(DeleteChat event) async {
    await _chatRepository.delete(event.value!);
  }

  Future<void> _mapUpdateChat(UpdateChat event) async {
    await _chatRepository.update(event.value.copyWith(saying: event.newSaying));
  }

  Future<ChatModel?> _mapAddChat(AddChat event) async {
    var key = newRandomKey();
    await _chatRepository.add(ChatModel(
        documentID: key,
        authorId: memberId,
        appId: appId,
        roomId: roomId,
        saying: event.saying,
        readAccess: readAccess,
    ));
    return await _chatRepository.get(key);
  }

  Future<ChatState?> _mapPostFetchedToState(
      ChatState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == ChatStatus.initial) {
        final values = await _fetchChats(limit: 5);
        return state.copyWith(
          status: ChatStatus.success,
          values: values,
          lastRowFetched: lastRowFetched,
          hasReachedMax: _hasReachedMax(values.length),
        );
      } else {
        final values =
            await _fetchChats(lastRowFetched: state.lastRowFetched, limit: 5);
        return values.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: ChatStatus.success,
                values: List.of(state.values)..addAll(values),
                lastRowFetched: lastRowFetched,
                hasReachedMax: _hasReachedMax(values.length),
              );
      }
    } on Exception {
      return state.copyWith(status: ChatStatus.failure);
    }
  }

  Future<List<ChatModel?>> _fetchChats(
      {Object? lastRowFetched, int? limit}) async {
    var values = await _chatRepository.valuesListWithDetails(
        orderBy: null,//'timestamp',
        descending: true,
        eliudQuery: eliudQuery,
        setLastDoc: _setLastRowFetched,
        startAfter: lastRowFetched,
        limit: limit);

    return values;
  }

  void _setLastRowFetched(Object? o) {
    lastRowFetched = o;
  }

  bool _hasReachedMax(int count) => count < _chatLimit ? true : false;
}
