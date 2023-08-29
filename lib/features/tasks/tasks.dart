import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key, required this.crossAxisCount});
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.surface;
    Color shadowcolor = Theme.of(context).colorScheme.shadow;
    Color surfaceTint = Theme.of(context).colorScheme.surfaceTint;
    int bordercolor = Theme.of(context).colorScheme.secondary.green;
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      crossAxisCount: crossAxisCount,
      childAspectRatio: 16 / 9,
      children: [
        Material(
          borderRadius: BorderRadius.circular(10),
          shadowColor: shadowcolor,
          color: color,
          surfaceTintColor: surfaceTint,
          elevation: 5.0,
          child: Container(
              height: 10,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(bordercolor),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                  "Heljkce vevhjer cwdnckw ecn ererrfevrbgrb rtrb e b bet bet bet bte bet \nwkvlekvjer tr vtrbrw\nferkvjioerlrekj ")),
        ),
      ],
    );
  }
}
