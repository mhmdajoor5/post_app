import 'package:post_app/feartures/post/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<void> addPost(PostModel post);
  Future<void> deletePost(int id);
  Future<void> updatePost(PostModel post);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<void> addPost(PostModel post) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
