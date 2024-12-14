import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_5al/screen/post_screen.dart';

import 'screen/post_detail_screen.dart';
import 'shared/bloc/post_bloc/posts_bloc.dart';
import 'shared/model/post.dart';
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const PostScreen(),
          onGenerateRoute: (routeSettings) {
            final argument = routeSettings.arguments;
            if (routeSettings.name == 'postDetail' && argument is Post) {
              return MaterialPageRoute(
                builder: (context) => PostDetailScreen(post: argument)
              );
            }
            return null;
          },
        )
      )
    );
  }
}
