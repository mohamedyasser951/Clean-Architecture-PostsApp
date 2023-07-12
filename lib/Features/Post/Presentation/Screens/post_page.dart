import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch_posts_app/Core/Theme/theme.dart';
import 'package:clean_arch_posts_app/Core/Widgets/error_widget.dart';
import 'package:clean_arch_posts_app/Core/Widgets/loading_widget.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Bloc/PostsBloc/posts_bloc.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Widgets/PostPageWidgets/post_item.dart';

import 'add_and_update_page.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const PostsPageBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddAndUpgatePage(isUpdate: false),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostsPageBody extends StatelessWidget {
  const PostsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is GetAllPostsLoadingState) {
          return const LoadingWidget();
        } else if (state is GetAllPostsErrorState) {
          return WidgetError(
            errorMessage: state.errorMessage,
          );
        } else if (state is GetAllPostsLoadedState) {
          return PostsBuilder(
            posts: state.posts,
          );
        }
        return const LoadingWidget();
      },
    );
  }
}

class PostsBuilder extends StatelessWidget {
  final List<PostEntity> posts;
  const PostsBuilder({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
      },
      child: ListView.separated(
        itemCount: posts.length,
        itemBuilder: (context, index) => PostItem(post: posts[index]),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
