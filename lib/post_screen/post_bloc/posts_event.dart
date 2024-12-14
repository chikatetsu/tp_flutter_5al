part of 'posts_bloc.dart';

@immutable
sealed class PostEvent {
  const PostEvent();
}

class GetAllPosts extends PostEvent {
  const GetAllPosts();
}

class GetPostById extends PostEvent {
  final int id;

  const GetPostById(this.id);
}

class CreatePost extends PostEvent {
  final Post post;

  const CreatePost(this.post);
}

class UpdatePost extends PostEvent {
  final Post post;

  const UpdatePost(this.post);
}
