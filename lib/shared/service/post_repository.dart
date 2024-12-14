import '../dto/create_post_dto.dart';
import '../dto/update_post_dto.dart';
import '../model/post.dart';
import 'post_data_source.dart';

class PostRepository {
  final PostDataSource postDataSource;

  const PostRepository({
    required this.postDataSource
  });

  Future<List<Post>> getAllPosts() async {
    return postDataSource.getAllPosts();
  }

  Future<Post> createPost(CreatePostDto dto) async {
    return postDataSource.createPost(dto);
  }

  Future<Post> updatePost(UpdatePostDto dto) async {
    return postDataSource.updatePost(dto);
  }
}