import 'package:flutter/material.dart';

class AlertCustom extends StatelessWidget {
  const AlertCustom({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
    );
  }
}
