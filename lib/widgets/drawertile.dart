import 'package:flutter/material.dart';
import 'package:todo_list/models/drawer_item.dart';

class DrawerTileCustom extends StatelessWidget {
  const DrawerTileCustom({super.key, required this.item});

  final DrawerItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        style: const ButtonStyle(
            enableFeedback: true,
            padding:
                MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15))),
        // onPressed: () => item.onpress,
        onPressed: () {
          Navigator.pushNamed(context, item.routename);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item.icon,
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
