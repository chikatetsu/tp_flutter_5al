part of 'posts_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error
}

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final PostException exception;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.exception = const UnknownException()
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    PostException? exception
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? List.from(this.posts),
      exception: exception ?? this.exception
    );
  }
}
