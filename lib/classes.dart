import 'package:flutter/material.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final Locale locale; // Use a Locale object directly

  Language({
    required this.id,
    required this.name,
    required this.flag,
    required this.locale,
  });

  // This is now the single source of truth for supported languages
  static List<Language> languageList() {
    return <Language>[
      Language(
        id: 1,
        name: 'English',
        flag: 'assets/images/us_flag.png',
        locale: const Locale('en', 'US'),
      ),
      Language(
        id: 2,
        name: 'Bahasa Malaysia',
        flag: 'assets/images/malaysia_flag.png',
        locale: const Locale('ms', 'MY'),
      ),
    ];
  }

  // Helper to get all locale objects
  static List<Locale> get allLocales =>
      languageList().map((lang) => lang.locale).toList();
}
