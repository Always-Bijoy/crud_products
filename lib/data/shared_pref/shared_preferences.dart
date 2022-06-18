import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  static const String keyAccessToken = "key_access_token";
  static const String keyUserId = "key_user_id";

  // static Future<void> setAccessToken(String accessToken) async {
  //   await SharedPreferences.getInstance().then((prefs) {
  //     prefs.setString(keyAccessToken, accessToken);
  //   });
  // }

  static setValue(String key, String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value!);
  }

  static Future<String?> getValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var value = prefs.getString(key);
      return value;
    } catch (error) {
      return null;
    }
  }

  static deleteKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
