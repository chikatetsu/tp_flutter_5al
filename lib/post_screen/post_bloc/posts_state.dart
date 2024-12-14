part of 'posts_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
}

class PostState {
  final PostStatus status;
  final List<Post> posts;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const []
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? List.from(this.posts),
    );
  }
}
