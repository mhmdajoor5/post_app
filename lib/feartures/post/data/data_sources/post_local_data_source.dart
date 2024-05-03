import 'package:post_app/feartures/post/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<void> cachePosts(List<PostModel> postModel);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  @override
  Future<void> cachePosts(List<PostModel> postModel) {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}
