import 'package:flutter/material.dart';
import 'package:myapp/classes.dart'; // Import the Language class

class LocaleProvider with ChangeNotifier {
  // Initialize with the locale of the first language in the list (English)
  Locale _locale = const Locale('en', 'US');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    // Check if the selected locale is supported
    if (!Language.allLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
