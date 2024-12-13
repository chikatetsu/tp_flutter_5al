import 'package:tp_flutter_5al/model/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post postToAdd);
  Future<Post> updatePost(Post newPost);
}
