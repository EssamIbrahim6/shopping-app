import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool getBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  static Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }
}
