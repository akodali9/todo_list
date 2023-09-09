import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static const String routename = '/settings-page';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool switchval = false;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
              enableFeedback: true,
              leading: const Icon(Icons.accessible),
              title: const Text("Text"),
              trailing: Switch(
                value: switchval,
                onChanged: null,
              ),),
        ],
      ),
    );
  }
}
