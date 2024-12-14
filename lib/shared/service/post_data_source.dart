import '../dto/create_post_dto.dart';
import '../dto/update_post_dto.dart';
import '../model/post.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(CreatePostDto dto);
  Future<Post> updatePost(UpdatePostDto dto);
}
