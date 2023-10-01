import 'package:shared_preferences/shared_preferences.dart';

class TemperatureUnitPreference {
  static const String _key = 'temperature_unit';

  static Future<void> setTemperatureUnit(bool unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, unit);
  }

  static Future<bool?> getTemperatureUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key);
  }
}
