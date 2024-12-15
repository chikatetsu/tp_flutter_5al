import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_5al/screen/post_edition.dart';

import '../shared/bloc/post_bloc/posts_bloc.dart';
import '../shared/dto/update_post_dto.dart';
import '../shared/model/post.dart';

class PostDetailScreen extends StatefulWidget {
  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.pushNamed(context, 'postDetail', arguments: post);
  }

  final Post post;

  const PostDetailScreen({
    super.key,
    required this.post
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Post _post;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: _onError,
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: switch (state.status) {
                PostStatus.loading || PostStatus.initial => _buildTitleLoading(context),
                PostStatus.success || PostStatus.error => _buildTitleSuccess(context)
              }
            ),
            body: switch (state.status) {
              PostStatus.loading || PostStatus.initial => _buildDescriptionLoading(context),
              PostStatus.success || PostStatus.error => _buildDescriptionSuccess(context)
            },
            floatingActionButton: FloatingActionButton(
              heroTag: 'editPost',
              onPressed: () => {
                showPostEditionDialog(
                  context: context,
                  dialogTitle: 'Modification du post',
                  onConfirm: _editPost,
                  title: _post.title,
                  description: _post.description
                )
              },
              child: const Icon(Icons.edit),
            ),
          );
        },
      ),
    );
  }

  void _onError(BuildContext context, PostState state) {
    if (state.status == PostStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.exception.message),
        ),
      );
    }
  }

  Widget _buildTitleLoading(BuildContext context) {
    return const SizedBox(
      width: 150,
      child: LinearProgressIndicator(
        backgroundColor: Colors.black26,
        color: Colors.black38,
      ),
    );
  }
  Widget _buildTitleSuccess(BuildContext context) {
    return Text(_post.title);
  }

  Widget _buildDescriptionLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _buildDescriptionSuccess(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(_post.description)
    );
  }

  void _editPost(BuildContext context, String title, String description) {
    _post = _post.copyWith(
      title: title,
      description: description
    );
    UpdatePostDto dto = UpdatePostDto(
      id: _post.id,
      title: _post.title,
      description: _post.description
    );
    context.read<PostBloc>().add(UpdatePost(dto));
  }
}
