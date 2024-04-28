import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntities>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(PostEntities post);
  Future<Either<Failure, Unit>> addPost(PostEntities post);
}
