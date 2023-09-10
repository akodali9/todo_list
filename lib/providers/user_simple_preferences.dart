import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static String gridSettingkey = "is_GridActive";
  static String usertokenkey = "user-auth-token";
  // userPrefs;

  static Future init() async {
    return await SharedPreferences.getInstance();
  }

  static Future saveGridActiveData(bool val) async {
    SharedPreferences userPrefs = await UserSimplePreferences.init();
    userPrefs.setBool(gridSettingkey, val);
  }

  static loadGridActiveData() async {
    SharedPreferences userPrefs = await UserSimplePreferences.init();
    return userPrefs.getBool(gridSettingkey);
  }

  static Future saveUserToken(String val) async {
    SharedPreferences userPrefs = await UserSimplePreferences.init();
    userPrefs.setString(usertokenkey, val);
  }
  
  static Future loadUserToken() async {
    SharedPreferences userPrefs = await UserSimplePreferences.init();
    return userPrefs.getString(usertokenkey);
    
  }

  static Future deleteUserToken() async {
    SharedPreferences userPrefs = await UserSimplePreferences.init();
    return userPrefs.remove(usertokenkey);
    
  }

}
