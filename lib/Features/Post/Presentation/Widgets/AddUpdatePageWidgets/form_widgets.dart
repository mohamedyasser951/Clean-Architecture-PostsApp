import 'package:clean_arch_posts_app/Core/Theme/theme.dart';
import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Bloc/AddUpdateDeletePostBloc/add_update_delete_post_bloc.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Widgets/AddUpdatePageWidgets/cutome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidgets extends StatefulWidget {
  final PostEntity? post;
  final bool isUpdate;



  const FormWidgets({super.key, this.post, required this.isUpdate});

  

  @override
  State<FormWidgets> createState() => _FormWidgetsState();
}

class _FormWidgetsState extends State<FormWidgets> {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomeTxetField(
                    text: "title",
                    isMultiLine: false,
                    controller:titleController),
                const SizedBox(
                  height: 10.0,
                ),
                CustomeTxetField(
                    text: "body",
                    isMultiLine: true,
                    controller: bodyController),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton.icon(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(primaryColor),
                    ),
                    onPressed: () {
                      validateAndAddOrUpdatePost();
                    },
                    icon: Icon(
                      widget.isUpdate ? Icons.edit : Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      widget.isUpdate ? "Update" : "Add",
                      style: const TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void validateAndAddOrUpdatePost() {
    bool isValidate = formKey.currentState!.validate();
    PostEntity post = PostEntity(
        id:widget.isUpdate ? widget.post!.id : null,

        title: titleController.text,
        body:bodyController.text);
    if (isValidate) {
      if (widget.isUpdate) {
      } else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
  


