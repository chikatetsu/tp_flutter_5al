import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../dto/create_post_dto.dart';
import '../../dto/update_post_dto.dart';
import '../../model/post.dart';
import '../../service/post_repository.dart';

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
    
    final dto = event.dto;
    final newPost = await postsRepository.createPost(dto);
    
    emit(state.copyWith(
      status: PostStatus.success,
      posts: List.from(state.posts)..add(newPost),
    ));
  }
  
  void _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));

    final dto = event.dto;
    await postsRepository.updatePost(dto);
    final updatedPosts = await postsRepository.getAllPosts();

    emit(state.copyWith(
      status: PostStatus.success,
      posts: updatedPosts
    ));
  }
}
