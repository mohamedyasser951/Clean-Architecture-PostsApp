import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch_posts_app/Core/Theme/theme.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Bloc/bloc/posts_bloc.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Screens/post_page.dart';

import 'service_locator.dart' as ServiceLocator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ServiceLocator.sl<PostsBloc>()..add(GetAllPostsEvent()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: const PostPage(),
        ));
  }
}
