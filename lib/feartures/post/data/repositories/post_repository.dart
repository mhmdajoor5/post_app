import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/core/network/network_info.dart';
import 'package:post_app/feartures/post/data/data_sources/post_local_data_source.dart';
import 'package:post_app/feartures/post/data/data_sources/post_remote_data_source.dart';
import 'package:post_app/feartures/post/data/models/post_model.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';
import 'package:post_app/feartures/post/domain/repositories/post_repositories.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostsRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntities>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntities post) async {
    final PostModel postModel =
        PostModel(title: post.title, body: post.body, id: post.id);

    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntities post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return _getMessage(() async {
      await remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<void> Function() deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
