// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LanguageProviderController with ChangeNotifier {
//   Locale? _appLocale;
//   Locale? get appLocale => _appLocale;

//   Future<void> initializeLanguage() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     String storedLanguageCode = sp.getString('language_code') ?? 'th';
//     _appLocale = Locale(storedLanguageCode);
//     notifyListeners();
//   }

//   Future<void> changeLanguage(Locale type) async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     _appLocale = type;

//     if (type == Locale('en')) {
//       await sp.setString('language_code', 'en');
//     } else {
//       await sp.setString('language_code', 'th');
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = Locale('th');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (locale == _locale) return;
    _locale = locale;
    saveLocale(locale);
    notifyListeners();
  }

  init() {
    getLocale().then((value) {
      _locale = value;
      notifyListeners();
    });
  }

  saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('language') ?? 'th';
    print(languageCode);
    return Locale(languageCode);
  }
}
