import 'dart:convert';

import 'package:clean_arch_posts_app/Core/Error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:clean_arch_posts_app/Features/Post/Data/Models/posts_model.dart';

abstract class RemoteDataSource {
  Future<List<PostsModel>> getAllPosts();
  Future<Unit> addPost(PostsModel postsModel);
  Future<Unit> updatePost(PostsModel postsModel);
  Future<Unit> deletePost(int postId);
}

const basicUrl = "https://jsonplaceholder.typicode.com";

class RemoteDataSourceImplem implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImplem({
    required this.client,
  });

  @override
  Future<List<PostsModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("$basicUrl/posts"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      List<PostsModel> posts = decodedJson
          .map<PostsModel>((postModel) => PostsModel.fromJson(postModel))
          .toList();
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostsModel postsModel) async {
    final response = await client.post(Uri.parse("$basicUrl/posts"));
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostsModel postsModel) async {
    final postId = postsModel.id;
    final body = {"title": postsModel.title, "body": postsModel.body};
    final response =
        await client.patch(Uri.parse("$basicUrl/posts/$postId"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$basicUrl/posts/$postId"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw (ServerException());
    }
  }
}
