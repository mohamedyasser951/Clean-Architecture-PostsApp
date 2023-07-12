part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class AddUpdateDeletePostLoadingState extends AddUpdateDeletePostState {}

class AddUpdateDeletePostSuccessMessageState extends AddUpdateDeletePostState {
  final String message;
  const AddUpdateDeletePostSuccessMessageState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class AddUpdateDeletePostErrorState extends AddUpdateDeletePostState {
  final String message;
  const AddUpdateDeletePostErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
