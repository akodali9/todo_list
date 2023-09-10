import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/user_provider.dart';

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
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).deletetoken();
              Navigator.pop(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
