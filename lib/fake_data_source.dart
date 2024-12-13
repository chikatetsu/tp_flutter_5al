import 'package:tp_flutter_5al/model/post.dart';
import 'package:tp_flutter_5al/posts_data_source.dart';

class FakePostsDataSource extends PostsDataSource {
  final List<Post> _fakePosts = const [
    Post(id: '1', title: 'Post 1', description: 'Description of'),
    Post(id: '2', title: 'Post 2', description: 'Description of'),
    Post(id: '3', title: 'Post 3', description: 'Description of')
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    /// Add the post to the list
    return _fakePosts[0];
  }

  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    /// Update the post in the list
    return _fakePosts[0];
  }
}