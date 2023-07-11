import 'package:flutter/material.dart';

class CustomeTxetField extends StatelessWidget {
  final String text;
  final bool isMultiLine;
  final TextEditingController controller;
  const CustomeTxetField({
    Key? key,
    required this.text,
    required this.isMultiLine,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? "$text required " : null,
      maxLines: isMultiLine ? 6 : 1,
      minLines: isMultiLine ? 6 : 1,
      decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
