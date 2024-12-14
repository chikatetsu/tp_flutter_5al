import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_5al/screen/post_detail_screen.dart';

import '../shared/model/post.dart';
import 'post_bloc/posts_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    _getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return switch (state.status) {
            PostStatus.loading || PostStatus.initial => _buildLoading(context),
            PostStatus.success => _buildSuccess(context, state.posts),
          };
        }
      )
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Post> posts) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getAllPosts();
        },
        child: ListView.separated(
          itemCount: posts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              title: Text(post.title),
              onTap: () => _onPostTap(context, post),
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'createNewPost',
        onPressed: () => _createPost(context),
        child: const Icon(Icons.add)
      )
    );
  }

  void _getAllPosts() {
    context.read<PostBloc>().add(const GetAllPosts());
  }

  void _createPost(BuildContext context) {
    Post post = const Post(id: 456, title: 'Nouveau post', description: 'description du nouveau post');
    context.read<PostBloc>().add(CreatePost(post));
  }

  void _onPostTap(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }
}
