import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String prefKey = "theme_mode";

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    String? themeModeString = prefs.getString(prefKey);
    if (themeModeString == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values
        .firstWhere((mode) => mode.toString() == themeModeString);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefKey, themeMode.toString());
  }
}
