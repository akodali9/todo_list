import 'package:flutter/material.dart';
import 'package:todo_list/providers/user_simple_preferences.dart';

class GridSettings extends ChangeNotifier {
  late bool isGridActive;
  // bool get _isGridActive => isGridActive;

  // GridSettings({});

  GridSettings(bool val) {
    isGridActive = true;
    if (val) {
      isGridActive = true;
    } else {
      isGridActive = false;
    }
  }

  setGridStatus(bool val) async {
    isGridActive = val;
    await UserSimplePreferences.saveGridActiveData(isGridActive);
    print(isGridActive);
    notifyListeners();
  }

  getGridStatus() async {
    isGridActive = await UserSimplePreferences.loadGridActiveData();
    notifyListeners();
  }
}
