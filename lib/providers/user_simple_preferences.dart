import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static String key = "is_GridActive";
  // userPrefs;

  static Future init() async {
    return await SharedPreferences.getInstance();
  }

  static Future saveGridActiveData(bool val) async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    userPrefs.setBool(key, val);
    // print(userPrefs.getBool('is_GridActive'));
  }

  static loadGridActiveData() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    return userPrefs.getBool(key);
  }
}
