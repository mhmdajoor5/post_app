import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/core/network/network_info.dart';
import 'package:post_app/feartures/post/data/data_sources/post_local_data_source.dart';
import 'package:post_app/feartures/post/data/data_sources/post_remote_data_source.dart';
import 'package:post_app/feartures/post/data/models/post_model.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';
import 'package:post_app/feartures/post/domain/repositories/post_repositories.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<PostEntities>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        localDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return right(localPosts);
      } on EmptyCacheException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntities post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.addPost(postModel);
        return right(unit);
      } else {
        return left(OfflineFailure());
      }
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deletePost(postId);
      return right(unit);
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntities post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.updatePost(postModel);
        return right(unit);
      } else {
        return left(OfflineFailure());
      }
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
