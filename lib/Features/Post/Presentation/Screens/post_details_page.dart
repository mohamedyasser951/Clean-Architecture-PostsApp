import 'package:clean_arch_posts_app/Core/Theme/theme.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Screens/add_and_update_page.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';

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
                // ElevatedButton.icon(
                //     style: const ButtonStyle(
                //         backgroundColor:
                //             MaterialStatePropertyAll(Colors.redAccent)),
                //     onPressed: () {},
                //     icon: const Icon(Icons.delete_outlined),
                //     label: const Text("Delete")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
