import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Core/Strings/error_strings.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({
    required this.getAllPostsUseCase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(GetAllPostsLoadingState());
        final failureOrPosts = await getAllPostsUseCase();
        emit(mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(GetAllPostsLoadingState());
        final failureOrPosts = await getAllPostsUseCase();
        emit(mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }
  PostsState mapFailureOrPostsToState(
      Either<Failure, List<PostEntity>> either) {
    return either.fold(
        (failure) =>
            GetAllPostsErrorState(errorMessage: mapFailureToMessage(failure)),
        (posts) => GetAllPostsLoadedState(posts: posts));
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case (OffLineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      case (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case (EmptyCacheFailure):
        return EMPTY_CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
