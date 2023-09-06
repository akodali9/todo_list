import 'package:flutter/material.dart';

class UserSettings extends ChangeNotifier {
  bool gridIconBool;

  UserSettings({this.gridIconBool = false});

  setGridIconBool(bool val) {
    gridIconBool = val;
    notifyListeners();
  }
}
