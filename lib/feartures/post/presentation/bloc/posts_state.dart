part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class GetAllPostsLoading extends PostsState {}

class GetAllPostsLoaded extends PostsState {
  final List<PostEntities> posts;

  GetAllPostsLoaded(this.posts);
}

class GetAllPostsError extends PostsState {
  final String message;

  GetAllPostsError({required this.message});
}
