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

  Future<Post> createPost(Post postToAdd) async {
    return postDataSource.createPost(postToAdd);
  }

  Future<Post> updatePost(Post newPost) async {
    return postDataSource.updatePost(newPost);
  }
}