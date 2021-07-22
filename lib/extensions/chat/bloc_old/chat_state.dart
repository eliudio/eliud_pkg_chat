import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_chat/model/chat_model.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

enum ChatStatus { initial, success, failure }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatModel?> values;
  final bool hasReachedMax;
  final Object? lastRowFetched;

  const ChatState({
    this.status = ChatStatus.initial,
    this.values = const <ChatModel>[],
    this.hasReachedMax = false,
    this.lastRowFetched
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatModel?>? values,
    bool? hasReachedMax,
    Object? lastRowFetched,
  }) {
    return ChatState(
      status: status ?? this.status,
      values: values ?? this.values,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastRowFetched: lastRowFetched?? this.lastRowFetched,
    );
  }

/*
  PostListPagedState replacePost(
      PostDetails value
  ) {
    List<PostDetails> newValues = [];
    for (int i = 0 ; i < values.length ; i++) {
      if (values[i].postModel.documentID != value.postModel.documentID) {
        newValues.add(values[i]);
      } else {
        newValues.add(value);
      }
    }

    return copyWith(
      values: newValues,
    );
  }

*/
  @override
  List<Object?> get props => [status, values, hasReachedMax, lastRowFetched];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is ChatState &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              ListEquality().equals(values, other.values) &&
              hasReachedMax == other.hasReachedMax &&
              lastRowFetched == other.lastRowFetched;
}
