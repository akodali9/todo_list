import 'package:flutter/material.dart';
import 'package:todo_list/providers/user_simple_preferences.dart';

class UserProvider extends ChangeNotifier {
  late String token;

  UserProvider(String val) {
    token = "";
    if (val != "") {
      token = val;
    } else {
      token = "";
    }
  }

  updatetoken(String val) {
    token = val;
    UserSimplePreferences.saveUserToken(val);
    notifyListeners();
  }

  loadtoken() async {
    token = await UserSimplePreferences.loadUserToken();
    notifyListeners();
  }

  deletetoken() {
    token = "";
    UserSimplePreferences.deleteUserToken();
    notifyListeners();
  }
}
