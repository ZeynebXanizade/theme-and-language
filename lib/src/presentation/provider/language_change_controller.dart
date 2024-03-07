import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale? _appLocale;
  Locale? get appLocal => _appLocale;
//kaydedilen dil
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return null;
    }
    String local = prefs.getString('language_code') ?? 'en';
    _appLocale = Locale(local.toString());
    return null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("az")) {
      // ignore: avoid_print
      print(type);
      _appLocale = const Locale("az");
      await prefs.setString('language_code', 'az');
    } else if (type == const Locale("ru")) {
      // ignore: avoid_print
      print(type);
      _appLocale = const Locale("ru");
      await prefs.setString('language_code', 'ru');
    } else if (type == const Locale("en")) {
      // ignore: avoid_print
      print(type);
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
    } else {
      return;
    }
    notifyListeners();
  }
}
