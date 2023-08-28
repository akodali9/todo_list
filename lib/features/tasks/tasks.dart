import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      children: [
        Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 10,
          child: Container(
              height: 10,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: const Text("Heljkce vevhjer")),
        ),
      ],
    );
  }
}
