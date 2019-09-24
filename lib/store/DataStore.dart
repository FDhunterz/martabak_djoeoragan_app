
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  Future<bool> setDataString(String name, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(name, value);
    return true;
  }

  Future<String> getDataString(String name) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(name) ?? "Tidak ditemukan";
  }

  Future<bool> setDataInteger(String name, int value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(name, value);
    return true;
  }

  Future<int> getDataInteger(String name) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(name) ?? 0;
  }

  Future<bool> clearData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    return true;
  }
}