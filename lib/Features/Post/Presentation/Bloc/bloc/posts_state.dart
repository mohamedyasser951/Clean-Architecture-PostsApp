part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class GetAllPostsLoadingState extends PostsState {}

class GetAllPostsLoadedState extends PostsState {
  final List<PostEntity> posts;
  const GetAllPostsLoadedState({
    required this.posts,
  });
  @override
  List<Object> get props => [posts];
}

class GetAllPostsErrorState extends PostsState {
  final String errorMessage;
  const GetAllPostsErrorState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
