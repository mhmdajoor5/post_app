import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/feartures/post/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<void> cachePosts(List<PostModel> postModel);
  Future<List<PostModel>> getCachedPosts();
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  final CACHE_POSTS = 'CACHE_POSTS';

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cachePosts(List<PostModel> postModel) {
    List postModelsToJson = postModel
        .map<Map<String, dynamic>>((PostModel) => PostModel.toJson())
        .toList();

    sharedPreferences.setString(CACHE_POSTS, jsonEncode(postModelsToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final jsonString = sharedPreferences.getString(CACHE_POSTS);
    if (jsonString != null) {
      List<dynamic> decodedJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel = decodedJsonData
          .map<PostModel>((jsonModel) => PostModel.fromJson(jsonModel))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
