import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';
import 'package:post_app/feartures/post/domain/repositories/post_repositories.dart';

class GetALLPostsUseCase {
  final PostRepository repository;

  GetALLPostsUseCase(this.repository);

  Future<Either<Failure, List<PostEntities>>> call() {
    return repository.getAllPosts();
  }
}
