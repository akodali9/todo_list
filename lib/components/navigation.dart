import 'package:flutter/material.dart';

class BottomCustomAppBar extends StatelessWidget {
  const BottomCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.only(left: 10.0),
      elevation: 2,
      height: 60,
      child: Row(
        children: [
          IconButton(
            enableFeedback: true,
            onPressed: () {},
            icon: const Icon(Icons.check_box_outlined),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            enableFeedback: true,
            onPressed: () {},
            icon: const Icon(Icons.draw_rounded),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            enableFeedback: true,
            onPressed: () {},
            icon: const Icon(Icons.image_outlined),
          ),
        ],
      ),
    );
  }
}
