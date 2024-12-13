import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return Expanded(
            child: switch (state.status) {
              PostStatus.initial || PostStatus.loading => _buildLoading(context),
              PostStatus.success => _buildSuccess(context, state.posts),
            }
          );
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
    return RefreshIndicator(
      onRefresh: () async {
        _getAllPosts();
      },
      child: ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            title: Text(post.title),
            onTap: () => _onPostTap(context, post),
          );
        },
      ),
    );
  }

  void _getAllPosts() {
    final postBloc = context.read<PostBloc>();
    postBloc.add(GetAllPosts());
  }

  void _onPostTap(BuildContext context, Post post) {}
}
