import 'package:eventplanningapp/services.dart';
import 'package:flutter/material.dart';

class AppthemeProvider extends ChangeNotifier {
ThemeMode apptheme  = parseThemeMode(MyServices.getString("currenttheme")) ?? ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    if (apptheme == newTheme) return;

    apptheme = newTheme;
    MyServices.setString('currenttheme', newTheme.toString().split('.').last);
    notifyListeners();
  }

  static ThemeMode? parseThemeMode(String? theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }
}
