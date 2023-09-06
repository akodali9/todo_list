import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings extends ChangeNotifier {
  bool gridIconBool;

  UserSettings({this.gridIconBool = false});

  setGridIconBool(bool val) async {
    gridIconBool = val;
    await UserSimplePreferences.saveData(val);
    notifyListeners();
  }

  getGridIconBool() async {
    gridIconBool = await UserSimplePreferences.loadData();
    notifyListeners();
  }
}

class UserSimplePreferences {
  static String key = "gridIconBool";
  static late SharedPreferences userprefs;

  static Future init() async {
    userprefs = await SharedPreferences.getInstance();
  }

  static Future saveData(bool val) async {
    userprefs.setBool(key, val);
    print(userprefs.getBool('gridIconBool'));
  }

  static loadData() {
    return userprefs.getBool(key)!;
  }
}
