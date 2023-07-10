import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final String errorMessage;
  const WidgetError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage,style: const TextStyle(fontWeight: FontWeight.bold),),);
  }
}
