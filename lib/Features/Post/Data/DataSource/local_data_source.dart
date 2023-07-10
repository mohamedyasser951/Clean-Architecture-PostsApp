// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:clean_arch_posts_app/Core/Error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_arch_posts_app/Features/Post/Data/Models/posts_model.dart';

abstract class LocaleDataSource {
  Future<List<PostsModel>> getCachedPosts();
  Future<Unit> cashePosts(List<PostsModel> posts);
}

const CASHED_POSTS = "CASHED_POSTS";

class LocaleDataSourceImplem implements LocaleDataSource {
  final SharedPreferences sharedPreferences;
  LocaleDataSourceImplem({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cashePosts(List<PostsModel> posts) async {
    final postsModelTojson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    await sharedPreferences.setString(
        CASHED_POSTS, json.encode(postsModelTojson));
    return Future.value(unit);
  }

  @override
  Future<List<PostsModel>> getCachedPosts() async {
    final jsonString = sharedPreferences.getString(CASHED_POSTS);
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);

      List<PostsModel> jsonToPostModel = decodedJsonData
          .map<PostsModel>(
              (jsonPostModel) => PostsModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
