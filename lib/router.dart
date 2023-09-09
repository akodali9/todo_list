import 'package:flutter/material.dart';
import 'package:todo_list/features/settings/settings_page.dart';
import 'package:todo_list/features/tasks/note_edit_area.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case NoteEditPage.routename:
      return MaterialPageRoute(
        builder: (_) => const NoteEditPage(),
        settings: routeSettings,
        maintainState: true,
      );
    case SettingsPage.routename:
      return MaterialPageRoute(
        builder: (_) => const SettingsPage(),
        settings: routeSettings,
        maintainState: true,
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text(
              "Error 404",
            ),
          ),
        ),
      );
  }
}
