import 'package:tp_flutter_5al/shared/service/posts_data_source.dart';

import '../model/post.dart';

class FakePostsDataSource extends PostsDataSource {
  final List<Post> _fakePosts = const [
    Post(id: '1', title: 'Post 1', description: 'Description of Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description of Post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description of Post 3')
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return _fakePosts.last;
  }

  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    int indexToUpdate = _fakePosts.indexWhere((post) => post.id == newPost.id);
    _fakePosts[indexToUpdate] = newPost;
    return _fakePosts[indexToUpdate];
  }
}