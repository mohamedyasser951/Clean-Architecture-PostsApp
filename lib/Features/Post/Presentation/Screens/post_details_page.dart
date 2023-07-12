import 'package:clean_arch_posts_app/Core/Theme/theme.dart';
import 'package:clean_arch_posts_app/Core/Utils/snack_bar_widget.dart';
import 'package:clean_arch_posts_app/Core/Widgets/loading_widget.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Bloc/AddUpdateDeletePostBloc/add_update_delete_post_bloc.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Screens/add_and_update_page.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Screens/post_page.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Widgets/DetailsPostPageWidgets/delete_widget.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsDetailsPage extends StatelessWidget {
  final PostEntity post;
  const PostsDetailsPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              post.body,
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primaryColor)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddAndUpgatePage(isUpdate: true, post: post),
                          ));
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Update")),
                ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent)),
                    onPressed: () {
                      deleteDialog(context, post.id!);
                    },
                    icon: const Icon(Icons.delete_outlined),
                    label: const Text("Delete")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void deleteDialog(BuildContext context, int postId) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
        listener: (context, state) {
          if (state is AddUpdateDeletePostErrorState) {
            snackBarWidget(context, state.message, Colors.red);
            Navigator.pop(context);
          } else if (state is AddUpdateDeletePostSuccessMessageState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const PostPage(),
                ),
                (route) => false);
            snackBarWidget(context, state.message, Colors.green);
          }
        },
        builder: (context, state) {
          if (state is AddUpdateDeletePostLoadingState) {
            return const AlertDialog(
              title: LoadingWidget(),
            );
          } else {
            return DeleteDialogWidget(
              postId: postId,
            );
          }
        },
      );
    },
  );
}
