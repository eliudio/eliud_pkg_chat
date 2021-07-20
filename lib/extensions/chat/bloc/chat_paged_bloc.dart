import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eliud_core/model/abstract_repository_singleton.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/tools/random.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_event.dart';
import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:eliud_pkg_feed/model/post_repository.dart';
import 'package:eliud_pkg_feed/tools/post_helper.dart';

const _postLimit = 5;

class PostListPagedBloc extends Bloc<ChatPagedEvent, PostListPagedState> {
  final String memberId;
  final PostRepository _postRepository;
  Object? lastRowFetched;
  EliudQuery eliudQuery;

  PostListPagedBloc(this.memberId, this.eliudQuery,
      {required PostRepository postRepository})
      : _postRepository = postRepository,
        super(const PostListPagedState());

  @override
  Stream<Transition<ChatPagedEvent, PostListPagedState>> transformEvents(
    Stream<ChatPagedEvent> events,
    TransitionFunction<ChatPagedEvent, PostListPagedState> transitionFn,
  ) {
    return super.transformEvents(
      events,
      transitionFn,
    );
  }

  @override
  Stream<PostListPagedState> mapEventToState(ChatPagedEvent event) async* {
    if (event is PostListPagedFetched) {
      var value = await _mapPostFetchedToState(state);
      if (value != null) yield value;
    } else if (event is UpdatePostPaged) {
      await _mapUpdatePost(event);

      // We update the entry in the current state avoiding interaction with repository
      var newListOfValues = <PostDetails>[];
      state.values.forEach((element) {
        if (element.postModel.documentID != event.value.documentID) {
          newListOfValues.add(element);
        } else {
          newListOfValues.add(element.copyWith(postModel: event.value));
        }
      });

      yield state.copyWith(values: newListOfValues);
    } else if (event is AddPostPaged) {
      var details = PostDetails(postModel: event.value);
      await _mapAddPost(event);
      List<PostDetails> newListOfValues = [];
      newListOfValues.add(details);
      newListOfValues.addAll(state.values);
      yield state.copyWith(values: newListOfValues);
    } else if (event is DeletePostPaged) {
      await _mapDeletePost(event);

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
    } else if (event is LikePostEvent) {
      yield await _updateEmotion(state, null, event.likeType, event.postDetail);
    } else if (event is LikeCommentPostEvent) {
      yield await _updateEmotion(
          state, event.postCommentContainer, event.likeType, event.postDetail);
    } else if (event is AddCommentEvent) {
      yield await _comment(state, event.comment, event.postDetail);
    } else if (event is AddCommentCommentEvent) {
      yield await _commentComment(
          state, event.postDetail, event.postCommentContainer, event.comment);
    } else if (event is DeleteCommentEvent) {
      yield await _deleteComment(state, event.deleteThis, event.postDetail);
    } else if (event is UpdateCommentEvent) {
      yield await _updateComment(
        state,
        event.updateThis,
        event.postDetail,
        event.newValue,
      );
    }
  }

  Future<void> _mapDeletePost(DeletePostPaged event) async {
    await _postRepository.delete(event.value!);
  }

  Future<void> _mapUpdatePost(UpdatePostPaged event) async {
    await _postRepository.update(event.value);
  }

  Future<void> _mapAddPost(AddPostPaged event) async {
    await _postRepository.add(event.value);
  }

  Future<PostListPagedState?> _mapPostFetchedToState(
      PostListPagedState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PostListPagedStatus.initial) {
        final values = await _fetchPosts(limit: 5);
        return state.copyWith(
          status: PostListPagedStatus.success,
          values: values,
          lastRowFetched: lastRowFetched,
          hasReachedMax: _hasReachedMax(values.length),
        );
      } else {
        final values =
            await _fetchPosts(lastRowFetched: state.lastRowFetched, limit: 5);
        return values.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: PostListPagedStatus.success,
                values: List.of(state.values)..addAll(values),
                lastRowFetched: lastRowFetched,
                hasReachedMax: _hasReachedMax(values.length),
              );
      }
    } on Exception {
      return state.copyWith(status: PostListPagedStatus.failure);
    }
  }

  Future<List<PostDetails>> _fetchPosts(
      {Object? lastRowFetched, int? limit}) async {
    var values = await _postRepository.valuesListWithDetails(
        orderBy: 'timestamp',
        descending: true,
        eliudQuery: eliudQuery,
        setLastDoc: _setLastRowFetched,
        startAfter: lastRowFetched,
        limit: limit);
    List<PostDetails> details = [];

    for (int i = 0; i < values.length; i++) {
      var postModel = values[i];
      var detail = await _loadComments(postModel!, postModel.appId!);
      details.add(detail);
    }

    return details;
  }

  void _setLastRowFetched(Object? o) {
    lastRowFetched = o;
  }

  bool _hasReachedMax(int postsCount) => postsCount < _postLimit ? true : false;

// ********************************* retrieve and map comments ****************************
  Future<PostCommentContainer> construct(
      String appId,
      PostCommentModel comment,
      List<PostCommentContainer?>? commentComments,
      bool? thisMemberLikesThisComment) async {
    return PostCommentContainer(
      postComment: comment,
      dateTime: comment.timestamp.toString(),
      member:
          await memberPublicInfoRepository(appId: appId)!.get(comment.memberId),
      comment: comment.comment!,
      postCommentContainer: commentComments,
      thisMemberLikesThisComment: thisMemberLikesThisComment,
    );
  }

  Future<List<PostCommentContainer>?> mapComments(
    String postId,
    List<PostCommentModel?>? sourceComments,
    String appId,
  ) async {
    if (sourceComments == null) return null;
    if (sourceComments.length == 0) return null;

    List<PostCommentContainer> comments = [];
    for (int i = 0; i < sourceComments.length; i++) {
      var comment = sourceComments[i];
      if (comment != null) {
        List<PostCommentModel?>? sourceCommentComments =
            await postCommentRepository(appId: appId)!.valuesList(
                orderBy: 'timestamp',
                descending: true,
                eliudQuery: EliudQuery()
                    .withCondition(
                        EliudQueryCondition('postId', isEqualTo: postId))
                    .withCondition(EliudQueryCondition('postCommentId',
                        isEqualTo: comment.documentID)));
        List<PostCommentContainer>? commentComments = await mapComments(
          postId,
          sourceCommentComments,
          appId,
        );

        var likeKey =
            PostHelper.getLikeKey(postId, comment.documentID, memberId);
        var like = await postLikeRepository(appId: appId)!.get(likeKey);

        var postCommentContainer =
            await construct(appId, comment, commentComments, like != null);
        comments.add(postCommentContainer);
      }
    }

    return comments;
  }

  Future<PostDetails> _loadComments(PostModel postModel, String appId) async {
    var likeKey = PostHelper.getLikeKey(postModel.documentID!, null, memberId);
    var like = await postLikeRepository(appId: appId)!.get(likeKey);

    List<PostCommentModel?>? sourceComments =
        await postCommentRepository(appId: appId)!.valuesList(
            orderBy: 'timestamp',
            descending: true,
            eliudQuery: EliudQuery()
                .withCondition(EliudQueryCondition('postId',
                    isEqualTo: postModel.documentID!))
                .withCondition(EliudQueryCondition(
                  'postCommentId',
                  isNull: true,
                )));
    List<PostCommentContainer>? comments = await mapComments(
      postModel.documentID!,
      sourceComments,
      appId,
    );
    return PostDetails(
        postModel: postModel,
        comments: comments,
        thisMembersLikeType: like == null ? null : like.likeType);
  }

  /* As a general rule, when updating data, be it adding a like, dislike, comment, ... we update the data in memory
     and allow the repository update happen in the background. As a matter of fact, there are firebase functions
     doing the counting of the likes async in the background anyway, so this is not only a performance optimisation,
     it is even a necessity even for some parts of the data, and hence making it a general approach is best.
   */

  // ********************************* create a comment ****************************
  Future<PostListPagedState> _comment(PostListPagedState theState,
      String comment, PostDetails postDetail) async {
    // First add the comment in the repository
    String postId = postDetail.postModel.documentID!;
    String appId = postDetail.postModel.appId!;
    var toAdd = PostCommentModel(
      documentID: newRandomKey(),
      postId: postId,
      memberId: memberId,
      appId: appId,
      comment: comment,
    );
    await postCommentRepository(appId: appId)!.add(toAdd);

    // Now update the state, rather then retrieve from repository
    PostCommentContainer container =
        await construct(postId, toAdd, null, false);
    final List<PostCommentContainer> newComments = [];
    newComments.add(container);
    var toCopy = postDetail.comments;
    if ((toCopy != null) && (toCopy.length > 0)) {
      for (int i = 0; i < toCopy.length; i++) {
        newComments.add(toCopy[i].copyWith());
      }
    }
    PostDetails newPostDetail = postDetail.copyWith(comments: newComments);
    return theState.replacePost(newPostDetail);
  }

// ********************************* create a comment on comment ****************************
  Future<PostListPagedState> _commentComment(
      PostListPagedState theState,
      PostDetails detail,
      PostCommentContainer postCommentContainer,
      String comment) async {
    var postId = detail.postModel.documentID!;
    var appId = detail.postModel.appId!;
    var addThis = PostCommentModel(
      documentID: newRandomKey(),
      postId: postId,
      postCommentId: postCommentContainer.postComment!.documentID,
      memberId: memberId,
      appId: appId,
      comment: comment,
    );

    postCommentRepository(appId: appId)!.add(addThis);

    var newComments =
        await _copyCommentCommentsAndAddOne(detail.comments, addThis);
    var newPostDetail = detail.copyWith(comments: newComments);
    var newState = theState.replacePost(newPostDetail);
    return newState;
  }

  Future<List<PostCommentContainer>?> _copyCommentCommentsAndAddOne(
    List<PostCommentContainer?>? toCopy,
    PostCommentModel toAdd,
  ) async {
    if (toCopy == null) return Future.value(null);
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      /*if ((toCopy[i] != null) &&
          (toCopy[i]!.postComment != null) &&
          (toCopy[i]!.postCommentContainer != null)) {
      */
      var theCopy = await _copyCommentCommentsAndAddOne(
          toCopy[i]!.postCommentContainer, toAdd);
      if (toCopy[i]!.postComment!.documentID == toAdd.postCommentId) {
        // is this the comment the parent of the item to be added then add it at the front
        PostCommentContainer container =
            await construct(toAdd.appId!, toAdd, null, false);
        if (theCopy != null) {
          theCopy.insert(0, container);
        } else {
          theCopy = [container];
        }
      }
      newComments.add(toCopy[i]!.copyWith(postCommentContainer: theCopy));
/*
      }
*/
    }
    return newComments;
  }

// ********************************* delete a comment ****************************
  Future<PostListPagedState> _deleteComment(PostListPagedState theState,
      PostCommentModel deleteThis, PostDetails postDetails) async {
    postCommentRepository(appId: postDetails.postModel.appId)!
        .delete(deleteThis);
    var newComments =
        _copyCommentsAndDeleteOne(postDetails.comments, deleteThis.documentID);
    var newPostDetails = postDetails.copyWith(comments: newComments);
    var newState = theState.replacePost(newPostDetails);
    return newState;
  }

  List<PostCommentContainer>? _copyCommentsAndDeleteOne(
    List<PostCommentContainer?>? toCopy,
    String? postCommentDocumentID,
  ) {
    if (toCopy == null) return null;
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      if (toCopy[i] != null) {
        if (toCopy[i]!.postComment != null) {
          if (toCopy[i]!.postComment!.documentID != postCommentDocumentID) {
            newComments.add(toCopy[i]!.copyWith(
                postCommentContainer: _copyCommentsAndDeleteOne(
                    toCopy[i]!.postCommentContainer, postCommentDocumentID)));
          }
        }
      }
    }
    return newComments;
  }

// ********************************* update a comment ****************************
  Future<PostListPagedState> _updateComment(
    PostListPagedState theState,
    PostCommentModel updateThis,
    PostDetails postDetails,
    String? newValue,
  ) async {
    postCommentRepository(appId: postDetails.postModel.appId)!
        .update(updateThis.copyWith(comment: newValue));

    var newComments = _copyCommentsAndUpdateComment(
        postDetails.comments, updateThis.documentID, newValue);
    var newPostDetail = postDetails.copyWith(comments: newComments);
    var newState = theState.replacePost(newPostDetail);
    return newState;
  }

  List<PostCommentContainer>? _copyCommentsAndUpdateComment(
      List<PostCommentContainer?>? toCopy,
      String? postCommentDocumentID,
      String? comment) {
    if (toCopy == null) return null;
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      var newValue;
/*
      if ((toCopy[i] != null) &&
          (toCopy[i]!.postCommentContainer != null) &&
          (toCopy[i]!.postComment != null)) {
*/
      if (toCopy[i]!.postComment!.documentID == postCommentDocumentID) {
        newValue = toCopy[i]!.copyWith(
            comment: comment,
            postCommentContainer: _copyCommentsAndUpdateComment(
                toCopy[i]!.postCommentContainer,
                postCommentDocumentID,
                comment));
      } else {
        newValue = toCopy[i]!.copyWith(
            postCommentContainer: _copyCommentsAndUpdateComment(
                toCopy[i]!.postCommentContainer,
                postCommentDocumentID,
                comment));
      }
      newComments.add(newValue);
/*
      }
*/
    }
    return newComments;
  }

// ********************************* update a like ****************************
  Future<PostListPagedState> _updateEmotion(
      PostListPagedState theState,
      PostCommentContainer? postCommentContainer,
      LikeType? likePressed,
      PostDetails postDetail) async {
    PostModel postModel = postDetail.postModel;
    String appId = postDetail.postModel.appId!;
    // We have firebase functions to update the post collection. One reason is performance, we shouldn't do this work on the client.
    // Second reason is security: the client, except the owner, can update the post.
    // We allow the firebase function to do it's thing in the background, async. In the meantime we determine the value here
    // as well, although not storing it in the db, just in memory. It's all fast, and correct

    // the like ID = postId - memberId
    var likeKey = PostHelper.getLikeKey(
        postModel.documentID,
        postCommentContainer != null
            ? postCommentContainer.postComment!.documentID
            : null,
        memberId);

    // find a like that might already exist
    var like = await postLikeRepository(appId: postModel.appId)!.get(likeKey);

    // keep track of the EXTRA likes / dislikes this like / dislike will cause
    int likesExtra = 0;
    int dislikesExtra = 0;

    // what is this like / dislike
    LikeType? thisMembersLikeType = LikeType.Unknown;

    // did we like / dislike before?
    if (like == null) {
      // we did not like / disliked before.
      thisMembersLikeType = likePressed;

      // did we press like or dislike and determine the extra like / dislike for in memory update
      if (likePressed == LikeType.Like) {
        likesExtra = 1;
      } else if (likePressed == LikeType.Dislike) {
        dislikesExtra = 1;
      }

      // create the like/dislike
      postLikeRepository(appId: appId)!.add(PostLikeModel(
          documentID: likeKey,
          postId: postModel.documentID,
          memberId: memberId,
          appId: appId,
          postCommentId: postCommentContainer == null
              ? null
              : postCommentContainer.postComment!.documentID,
          likeType: likePressed));
    } else {
      // we already liked / disliked before
      if (like.likeType != likePressed) {
        // we changed from like to dislike or vice versa
        thisMembersLikeType = likePressed;

        // We changed from dislike to like, which means: count down dislikes and count up likes
        if (likePressed == LikeType.Like) {
          // changing a dislike into a like
          likesExtra = 1;
          dislikesExtra = -1;
          // We changed from like to dislike, which means: count down likes and count up dislikes
        } else if (likePressed == LikeType.Dislike) {
          // changing a like into a dislike
          dislikesExtra = 1;
          likesExtra = -1;
        }

        // update the like / dislike
        postLikeRepository(appId: appId)!
            .update(like.copyWith(likeType: likePressed));
      } else {
        // we undo a like
        if (likePressed == LikeType.Like) {
          likesExtra = -1;
          // we undo a dislike
        } else if (likePressed == LikeType.Dislike) {
          dislikesExtra = -1;
        }

        // and update  but nothing changed in terms of likeType... it must mean we want to unlike
        await postLikeRepository(appId: appId)!.delete(like);
      }
    }
    if (postCommentContainer == null) {
      // update the state without having to retrieving it from the db
      var newPostDetail = postDetail.copyWith(
          postModel: postModel.copyWith(
              likes: postModel.likes == null
                  ? likesExtra
                  : postModel.likes! + likesExtra,
              dislikes: postModel.dislikes == null
                  ? dislikesExtra
                  : postModel.dislikes! + dislikesExtra),
          thisMembersLikeType: thisMembersLikeType);
      return theState.replacePost(newPostDetail);
    } else {
      // just implement for 1 element on top level
      // update the state without having to retrieving it from the db
      return theState.replacePost(postDetail.copyWith(
          comments: _copyCommentsAndUpdateALike(
              postDetail.comments,
              postCommentContainer.postComment!.documentID,
              thisMembersLikeType == LikeType.Like,
              likesExtra)));
    }
  }

  List<PostCommentContainer>? _copyCommentsAndUpdateALike(
      List<PostCommentContainer?>? toCopy,
      String? postCommentDocumentID,
      bool? thisMemberLikesThisComment,
      int likesExtra) {
    if (toCopy == null) return null;
    if (toCopy.length == 0) return [];

    final List<PostCommentContainer> newComments = [];
    for (int i = 0; i < toCopy.length; i++) {
      var newValue;
      if ((toCopy[i] != null) && (toCopy[i]!.postComment != null)) {
        if (toCopy[i]!.postComment!.documentID == postCommentDocumentID) {
          newValue = toCopy[i]!.copyWith(
              thisMemberLikesThisComment: thisMemberLikesThisComment,
              postComment: toCopy[i]!.postComment!.copyWith(
                    likes: toCopy[i]!.postComment!.likes == null
                        ? likesExtra
                        : toCopy[i]!.postComment!.likes! + likesExtra,
                  ),
              postCommentContainer: _copyCommentsAndUpdateALike(
                  toCopy[i]!.postCommentContainer,
                  postCommentDocumentID,
                  thisMemberLikesThisComment,
                  likesExtra));
        } else {
          newValue = toCopy[i]!.copyWith(
              postCommentContainer: _copyCommentsAndUpdateALike(
                  toCopy[i]!.postCommentContainer,
                  postCommentDocumentID,
                  thisMemberLikesThisComment,
                  likesExtra));
        }
        newComments.add(newValue);
      }
    }
    return newComments;
  }
}
