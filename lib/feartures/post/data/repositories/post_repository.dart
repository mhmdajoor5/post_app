import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/feartures/post/data/data_sources/post_local_data_source.dart';
import 'package:post_app/feartures/post/data/data_sources/post_remote_data_source.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';
import 'package:post_app/feartures/post/domain/repositories/post_repositories.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<PostEntities>>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntities post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntities post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
