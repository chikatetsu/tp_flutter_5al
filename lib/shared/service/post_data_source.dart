import '../model/post.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> getPostById(int id);
  Future<Post> createPost(Post postToAdd);
  Future<Post> updatePost(Post newPost);
}
