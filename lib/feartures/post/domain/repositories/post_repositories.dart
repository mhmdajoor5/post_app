import 'package:dartz/dartz.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';

abstract class PostRepository {
  Future<Either<String, List<PostEntities>>> getAllPosts();
  Future<Either<String, bool>> deletePost(int id);
  Future<Either<String, bool>> updatePost(PostEntities post);
  Future<Either<String, bool>> addPost(PostEntities post);
}
