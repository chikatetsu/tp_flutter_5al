import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_5al/screen/post_detail_screen.dart';
import 'package:tp_flutter_5al/shared/dto/create_post_dto.dart';

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
        onPressed: () => _showDialog(context),
        child: const Icon(Icons.add)
      )
    );
  }

  void _showDialog(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String title = '';
    String description = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nouveau post'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Titre'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez préciser le titre du post';
                    }
                    return null;
                  },
                  onChanged: (String? value) => {
                    if (value != null) {
                      title = value
                    }
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    alignLabelWithHint: true
                  ),
                  maxLines: 5,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez préciser la description du post';
                    }
                    return null;
                  },
                  onSaved: (String? value) => {
                    if (value != null) {
                      description = value
                    }
                  }
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Annuler')
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save(),
                            _createPost(context, title, description)
                          }
                        },
                        child: const Text('Confirmer')
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        );
      }
    );
  }

  void _getAllPosts() {
    context.read<PostBloc>().add(const GetAllPosts());
  }

  void _createPost(BuildContext context, String title, String description) {
    CreatePostDto dto = CreatePostDto(
      title: title,
      description: description
    );
    context.read<PostBloc>().add(CreatePost(dto));
    Navigator.of(context).pop();
  }

  void _onPostTap(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }
}
