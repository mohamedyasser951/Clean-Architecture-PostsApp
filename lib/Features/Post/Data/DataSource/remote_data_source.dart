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
  Future<Unit> addPost(PostsModel postsModel) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostsModel postsModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
