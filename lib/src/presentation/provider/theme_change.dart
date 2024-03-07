import 'package:flutter/material.dart';
import 'package:reservation/src/config/themes.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Varsayılan olarak sistem temasını kullan

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  Object getTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        return ThemesApp.lightTheme;
      case ThemeMode.dark:
        return ThemesApp.dartTheme;
      default:
        return _themeMode;
    }
  }
}