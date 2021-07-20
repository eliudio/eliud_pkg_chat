import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

enum PostListPagedStatus { initial, success, failure }

class PostCommentContainer extends Equatable {
  final PostCommentModel ?postComment;
  final String ?dateTime;
  final MemberPublicInfoModel ?member;
  final String ?comment;
  final bool ?thisMemberLikesThisComment;

  // comments on this comment
  final List<PostCommentContainer?>? postCommentContainer;

  PostCommentContainer({this.postComment, this.dateTime, this.member, this.comment, this.thisMemberLikesThisComment, this.postCommentContainer});

  PostCommentContainer copyWith({PostCommentModel? postComment, String? dateTime, MemberPublicInfoModel? member, String? comment, bool? thisMemberLikesThisComment, List<PostCommentContainer>? postCommentContainer}) {
    return PostCommentContainer(postComment: postComment ?? this.postComment, dateTime: dateTime ?? this.dateTime, member: member ?? this.member, comment : comment ?? this.comment, thisMemberLikesThisComment: thisMemberLikesThisComment ?? this.thisMemberLikesThisComment, postCommentContainer: postCommentContainer ?? this.postCommentContainer);
  }

  @override
  List<Object?> get props => [postComment, dateTime, member, comment, thisMemberLikesThisComment, postCommentContainer];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostCommentContainer &&
              runtimeType == other.runtimeType &&
              postComment == other.postComment &&
              dateTime == other.dateTime &&
              member == other.member &&
              comment == other.comment &&
              thisMemberLikesThisComment == other.thisMemberLikesThisComment;
}

class PostDetails extends Equatable {
  final List<PostCommentContainer>? comments;
  final LikeType? thisMembersLikeType;
  final PostModel postModel;

  PostDetails({this.comments, this.thisMembersLikeType, required this.postModel});

  PostDetails copyWith({List<PostCommentContainer>? comments, LikeType? thisMembersLikeType, PostModel? postModel}) {
    return PostDetails(comments: comments ?? this.comments, thisMembersLikeType: thisMembersLikeType ?? this.thisMembersLikeType, postModel: postModel ?? this.postModel);
  }

  @override
  List<Object?> get props => [comments, postModel, thisMembersLikeType];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostDetails &&
              runtimeType == other.runtimeType &&
              comments == other.comments &&
              postModel == other.postModel &&
              thisMembersLikeType == other.thisMembersLikeType;
}

class PostListPagedState extends Equatable {
  final PostListPagedStatus status;
  final List<PostDetails> values;
  final bool hasReachedMax;
  final Object? lastRowFetched;

  const PostListPagedState({
    this.status = PostListPagedStatus.initial,
    this.values = const <PostDetails>[],
    this.hasReachedMax = false,
    this.lastRowFetched
  });

  PostListPagedState copyWith({
    PostListPagedStatus? status,
    List<PostDetails>? values,
    bool? hasReachedMax,
    Object? lastRowFetched,
  }) {
    return PostListPagedState(
      status: status ?? this.status,
      values: values ?? this.values,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastRowFetched: lastRowFetched?? this.lastRowFetched,
    );
  }

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

  @override
  List<Object?> get props => [status, values, hasReachedMax, lastRowFetched];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is PostListPagedState &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              ListEquality().equals(values, other.values) &&
              hasReachedMax == other.hasReachedMax &&
              lastRowFetched == other.lastRowFetched;
}
