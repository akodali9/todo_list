import 'package:flutter/material.dart';

class BottomCustomAppBar extends StatefulWidget {
  const BottomCustomAppBar({super.key});

  @override
  State<BottomCustomAppBar> createState() => _BottomCustomAppBarState();
}

class _BottomCustomAppBarState extends State<BottomCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.only(left: 10.0),
      elevation: 2,
      height: 60,
      child: Row(
        children: [
          IconButton(
            tooltip: "New list",
            enableFeedback: true,
            onPressed: () {},
            icon: const Icon(Icons.check_box_outlined),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            tooltip: "New drawing note",
            enableFeedback: true,
            onPressed: () {},
            icon: const Icon(Icons.draw_rounded),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            tooltip: "New photo note",
            enableFeedback: true,
            onPressed: () {},
            icon: const Icon(Icons.image_outlined),
          ),
        ],
      ),
    );
  }
}
