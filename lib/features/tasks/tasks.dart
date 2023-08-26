import 'package:flutter/material.dart';

class Tasks_Screen extends StatelessWidget {
  const Tasks_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: EdgeInsets.all(10),
      crossAxisCount: 2,
      children: [
        Material(
          elevation: 10,
          child: Container(
              height: 10,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Text("Heljkce vevhjer")),
        ),
      ],
    );
  }
}
