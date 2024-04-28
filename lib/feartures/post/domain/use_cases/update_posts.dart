import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';
import 'package:post_app/feartures/post/domain/repositories/post_repositories.dart';

class UpdatePostsUseCase {
  final PostRepository repository;

  UpdatePostsUseCase(this.repository);

  Future<Either<Failure, Unit>> call(PostEntities post) {
    return repository.updatePost(post);
  }
}
