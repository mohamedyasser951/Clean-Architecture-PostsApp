import 'package:clean_arch_posts_app/Core/Error/failure.dart';
import 'package:clean_arch_posts_app/Core/Strings/error_strings.dart';
import 'package:clean_arch_posts_app/Core/Strings/sucess_strings.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/add_post.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/delet_post.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/UseCase/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  AddPostUseCase addPost;
  UpdatePostUseCase updatePost;
  DeletePostUseCase deletePost;
  AddUpdateDeletePostBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(AddUpdateDeletePostLoadingState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(mapFailureOrDoneMessageToState(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(AddUpdateDeletePostLoadingState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(mapFailureOrDoneMessageToState(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(AddUpdateDeletePostLoadingState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(mapFailureOrDoneMessageToState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddUpdateDeletePostState mapFailureOrDoneMessageToState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => AddUpdateDeletePostErrorState(
            message: mapFailureToMessage(failure)),
        (_) => AddUpdateDeletePostSuccessMessageState(message: message));
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case (OffLineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      case (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
