import 'package:clean_arch_posts_app/Features/Post/Presentation/Screens/post_details_page.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';

class PostItem extends StatelessWidget {
  final PostEntity post;
  const PostItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(post.id.toString()),
      ),
      title: Text(post.title),
      subtitle: Text(post.body),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostsDetailsPage(post: post),
            ));
      },
    );
  }
}
