
// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, unnecessary_null_comparison, avoid_print
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  ///  Login
  ///  SharedPreferencesUtil.saveID(

  static void storeId(String storeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('storeId', storeId);
  }

  // Utility Method: Save phoneno
  static void storeName(String storeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('storeName', storeName);
  } // Utility Method: Save ImageURL

}

class SharedPrefService {
  static  SharedPreferences pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }
}
