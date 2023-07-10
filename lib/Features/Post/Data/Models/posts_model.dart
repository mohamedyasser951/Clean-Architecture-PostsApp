import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';

class PostsModel extends PostEntity {
  const PostsModel(
      {required super.id, required super.title, required super.body});

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(id: json["id"], title: json["title"], body: json["body"]);
  }

   Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "body": body};
  }
}
