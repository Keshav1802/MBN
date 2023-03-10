import 'package:shared_preferences/shared_preferences.dart';

class Utils{
  static Future<bool> clearAllValue() async {
    //this function clear all values from shared preferences and getx state
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}