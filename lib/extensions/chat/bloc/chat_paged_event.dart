import 'package:eliud_pkg_feed/extensions/feed/postlist_paged/postlist_paged_state.dart';
import 'package:eliud_pkg_feed/model/post_comment_model.dart';
import 'package:eliud_pkg_feed/model/post_like_model.dart';
import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostPagedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostListPagedFetched extends PostPagedEvent {
  PostListPagedFetched();
}

class DeletePostPaged extends PostPagedEvent {
  final PostModel? value;

  DeletePostPaged({ this.value });

  @override
  List<Object?> get props => [ value ];
}

class AddPostPaged extends PostPagedEvent {
  final PostModel value;

  AddPostPaged({ required this.value });

  @override
  List<Object?> get props => [ value ];
}

class UpdatePostPaged extends PostPagedEvent {
  final PostModel value;

  UpdatePostPaged({ required this.value });

  @override
  List<Object?> get props => [ value ];
}

class LikePostEvent extends PostPagedEvent {
  final PostDetails postDetail;
  final LikeType likeType;

  LikePostEvent(this.postDetail, this.likeType);

  @override
  List<Object> get props => [ postDetail, likeType ];
}

class LikeCommentPostEvent extends PostPagedEvent {
  final PostDetails postDetail;
  final PostCommentContainer postCommentContainer;
  final LikeType likeType;

  LikeCommentPostEvent(this.postDetail, this.postCommentContainer, this.likeType);

  @override
  List<Object> get props => [ postDetail, postCommentContainer, likeType ];
}

class DeletePostEvent extends PostPagedEvent {
  final PostDetails postDetail;

  DeletePostEvent(this.postDetail);

  @override
  List<Object> get props => [ postDetail ];
}

class AddCommentEvent extends PostPagedEvent {
  final PostDetails postDetail;
  final String comment;

  AddCommentEvent(this.postDetail, this.comment);

  @override
  List<Object> get props => [ postDetail, comment ];
}

class AddCommentCommentEvent extends PostPagedEvent {
  final PostDetails postDetail;
  final PostCommentContainer postCommentContainer;
  final String comment;

  AddCommentCommentEvent(this.postDetail, this.postCommentContainer, this.comment);

  @override
  List<Object> get props => [ postCommentContainer, comment ];
}

class DeleteCommentEvent extends PostPagedEvent {
  final PostDetails postDetail;
  final PostCommentModel deleteThis;

  DeleteCommentEvent(this.postDetail, this.deleteThis);

  @override
  List<Object> get props => [ deleteThis ];
}

class UpdateCommentEvent extends PostPagedEvent {
  final PostDetails postDetail;
  final PostCommentModel updateThis;
  final String newValue;

  UpdateCommentEvent(this.postDetail, this.updateThis, this.newValue);

  @override
  List<Object> get props => [ postDetail, updateThis, newValue ];
}

class UpdatePostEvent extends PostPagedEvent {
  final PostDetails postDetail;
  final String comment;

  UpdatePostEvent(this.postDetail, this.comment);

  @override
  List<Object> get props => [ postDetail, comment ];
}
