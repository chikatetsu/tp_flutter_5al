import 'package:tp_flutter_5al/shared/service/posts_data_source.dart';

import '../model/post.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;

  const PostsRepository({
    required this.postsDataSource
  });

  Future<List<Post>> getAllPosts() {
    return postsDataSource.getAllPosts();
  }

  Future<Post> createPost(Post postToAdd) {
    return postsDataSource.createPost(postToAdd);
  }

  Future<Post> updatePost(Post newPost) {
    return postsDataSource.updatePost(newPost);
  }
}