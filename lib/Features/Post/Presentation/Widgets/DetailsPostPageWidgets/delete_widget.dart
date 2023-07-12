import 'package:flutter/material.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
        onPressed: () {},
        icon: const Icon(Icons.delete_outlined),
        label: const Text("Delete"));
  }

  // void showDeleteDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) =>null,
  //   );
  // }
}
