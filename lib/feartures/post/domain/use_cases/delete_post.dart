import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/feartures/post/domain/repositories/post_repositories.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);
  Future<Either<Failure, Unit>> call(int id) {
    return repository.deletePost(id);
  }
}
