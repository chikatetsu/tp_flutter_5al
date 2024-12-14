import '../dto/create_post_dto.dart';
import '../dto/update_post_dto.dart';
import '../model/post.dart';
import 'post_data_source.dart';

class FakePostDataSource extends PostDataSource {
  final List<Post> _fakePosts = [
    Post(id: 1, title: 'Post 1', description: 'Description of Post 1'),
    Post(id: 2, title: 'Post 2', description: 'Description of Post 2'),
    Post(id: 3, title: 'Post 3', description: 'Description of Post 3')
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(CreatePostDto dto) async {
    await Future.delayed(const Duration(seconds: 1));
    int lastId = _fakePosts.length + 1;
    Post postToAdd = Post(
      id: lastId,
      title: dto.title,
      description: dto.description
    );
    _fakePosts.add(postToAdd);
    return _fakePosts.last;
  }

  @override
  Future<Post> updatePost(UpdatePostDto dto) async {
    await Future.delayed(const Duration(seconds: 1));
    int indexToUpdate = _fakePosts.indexWhere((post) => post.id == dto.id);
    _fakePosts[indexToUpdate] = _fakePosts[indexToUpdate].copyWith(
      title: dto.title,
      description: dto.description
    );
    return _fakePosts[indexToUpdate];
  }
}