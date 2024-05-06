import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/core/strings/failures.dart';
import 'package:post_app/feartures/post/domain/entities/post_entities.dart';
import 'package:post_app/feartures/post/domain/use_cases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc(this.getAllPostsUseCase) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(GetAllPostsLoading());
        final failureOrPosts = await getAllPostsUseCase();

        emit(_mapFailureOrPostsToMessage(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(GetAllPostsLoading());
        final failureOrPosts = await getAllPostsUseCase();

        emit(_mapFailureOrPostsToMessage(failureOrPosts));
      }
    });
  }
}

PostsState _mapFailureOrPostsToMessage(
    Either<Failure, List<PostEntities>> either) {
  return either.fold(
    (failure) => GetAllPostsError(message: mapFailureToMessage(failure)),
    (posts) => GetAllPostsLoaded(posts),
  );
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure _:
      return SERVER_FAILURE_MESSAGE;
    case EmptyCacheFailure _:
      return EMPTY_CACHE_FAILURE_MESSAGE;
    case OfflineFailure _:
      return OFFLINE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
