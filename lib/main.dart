import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_5al/post_screen/post_bloc/posts_bloc.dart';
import 'package:tp_flutter_5al/post_screen/post_screen.dart';

import 'shared/service/fake_post_data_source.dart';
import 'shared/service/post_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(
        postDataSource: FakePostDataSource()
      ),
      child: BlocProvider(
        create: (context) => PostBloc(
          postsRepository: context.read<PostRepository>()
        ),
        child: const MaterialApp(
          home: PostScreen()
        )
      )
    );
  }
}
