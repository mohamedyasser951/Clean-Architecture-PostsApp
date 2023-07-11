import 'package:clean_arch_posts_app/Core/Theme/theme.dart';
import 'package:clean_arch_posts_app/Features/Post/Presentation/Widgets/AddUpdatePageWidgets/cutome_text_field.dart';
import 'package:flutter/material.dart';

import 'package:clean_arch_posts_app/Features/Post/Domain/Entities/post_entity.dart';

class AddAndUpgatePage extends StatefulWidget {
  final PostEntity? post;
  final bool isUpdate;

  const AddAndUpgatePage({
    Key? key,
    this.post,
    required this.isUpdate,
  }) : super(key: key);

  @override
  State<AddAndUpgatePage> createState() => _AddAndUpgatePageState();
}

class _AddAndUpgatePageState extends State<AddAndUpgatePage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController bodyController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdate ? "Edit Post" : "Post Details"),
        centerTitle: true,
      ),
      body: Center(
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
                      controller: titleController),
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
                      onPressed: () {},
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
      ),
    );
  }
}
