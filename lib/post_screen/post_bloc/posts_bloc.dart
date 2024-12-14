import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../shared/model/post.dart';
import '../../shared/service/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postsRepository;

  PostBloc({required this.postsRepository}) : super(const PostState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    
    final posts = await postsRepository.getAllPosts();
    
    emit(state.copyWith(
      status: PostStatus.success,
      posts: posts,
    ));
  }
  
  void _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    
    final newPost = event.post;
    await postsRepository.createPost(newPost);
    
    emit(state.copyWith(
      status: PostStatus.success,
      posts: List.from(state.posts)..add(newPost),
    ));
  }
  
  void _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    final newPost = event.post;
    await postsRepository.updatePost(newPost);
    final updatedPosts = await postsRepository.getAllPosts();

    emit(state.copyWith(
      status: PostStatus.success,
      posts: updatedPosts
    ));
  }
}
