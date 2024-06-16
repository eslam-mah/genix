import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences sharedPreferences;

  static Future<void> cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print("SharedPreferences initialized.");
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    bool result;
    if (value is bool) {
      result = await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      result = await sharedPreferences.setString(key, value);
    } else if (value is int) {
      result = await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      result = await sharedPreferences.setDouble(key, value);
    } else {
      result = false;
    }
    print("Set data for key $key with value $value: $result");
    return result;
  }

  static dynamic getData({required String key}) {
    var value = sharedPreferences.get(key);
    print("Get data for key $key: $value");
    return value;
  }

  static void deleteData({required String key}) {
    sharedPreferences.remove(key);
    print("Deleted data for key $key");
  }

  static Future<void> clearData() async {
    await sharedPreferences.clear();
    print("Cleared all data");
  }

  static String? getCustomToken() {
    var token = getData(key: 'customToken') as String?;
    print("Retrieved token: $token");
    return token;
  }

  static bool isUserSignedIn() {
    String? token = getCustomToken();
    bool signedIn = token != null && token.isNotEmpty;
    print("Is user signed in: $signedIn");
    return signedIn;
  }
}
