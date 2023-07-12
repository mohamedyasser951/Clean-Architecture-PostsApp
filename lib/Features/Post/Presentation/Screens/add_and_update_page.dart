import 'package:clean_arch_posts_app/Core/Utils/snack_bar_widget.dart';
import 'package:clean_arch_posts_app/Core/Widgets/loading_widget.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Bloc/AddUpdateDeletePostBloc/add_update_delete_post_bloc.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Widgets/AddUpdatePageWidgets/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAndUpgatePage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdate;

  const AddAndUpgatePage({
    Key? key,
    this.post,
    required this.isUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? "Edit Post" : "Post Details"),
          centerTitle: true,
        ),
        body: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is AddUpdateDeletePostErrorState) {
              snackBarWidget(context, state.message, Colors.red);
            } else if (state is AddUpdateDeletePostSuccessMessageState) {
              snackBarWidget(context, state.message, Colors.green);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is AddUpdateDeletePostLoadingState) {
              return const LoadingWidget();
            }
            return FormWidgets(
              isUpdate: isUpdate,
              post: isUpdate ? post : null,
            );
          },
        ));
  }
}
