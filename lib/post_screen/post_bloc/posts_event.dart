part of 'posts_bloc.dart';

@immutable
sealed class PostEvent {
  const PostEvent();
}

class GetAllPosts extends PostEvent {
  const GetAllPosts();
}

class CreatePost extends PostEvent {
  final CreatePostDto dto;

  const CreatePost(this.dto);
}

class UpdatePost extends PostEvent {
  final UpdatePostDto dto;

  const UpdatePost(this.dto);
}
