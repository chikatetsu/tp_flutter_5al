import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../post_screen/post_bloc/posts_bloc.dart';
import '../shared/model/post.dart';

class PostDetailScreen extends StatelessWidget {
  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, 'postDetail', arguments: post);
  }

  final Post post;

  const PostDetailScreen({
    super.key,
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(post.title)
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return switch (state.status) {
            PostStatus.loading || PostStatus.initial => _buildLoading(context),
            PostStatus.success => _buildSuccess(context, state.posts),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'editPost',
        onPressed: () => _editPost(context),
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Post> posts) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(post.description)
    );
  }

  void _editPost(BuildContext context) {
    Post post = const Post(id: '2',
        title: 'Edited post',
        description: 'description du post édité');
    context.read<PostBloc>().add(UpdatePost(post));
  }
}
