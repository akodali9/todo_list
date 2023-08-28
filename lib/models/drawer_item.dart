import 'package:flutter/material.dart';

class DrawerItem {
  final Icon icon;
  final String name;
  final VoidCallback onpress;

  DrawerItem({
    required this.icon,
    required this.name,
    required this.onpress,
  });
}
