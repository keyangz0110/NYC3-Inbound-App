import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  LocaleService();

  static const String _prefsKey = 'app_locale';
  static const Locale defaultLocale = Locale('en', 'US');

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('es', '419'),
    Locale('zh', 'CN'),
    Locale('id', 'ID'),
    Locale('fr', 'FR'),
  ];

  Locale _locale = defaultLocale;

  Locale get locale => _locale;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    if (saved == null) {
      return;
    }

    final parsed = _parseLocale(saved);
    if (parsed != null) {
      _locale = parsed;
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!_isSupported(locale)) {
      return;
    }

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, _localeToTag(locale));
  }

  static Locale? _parseLocale(String tag) {
    final parts = tag.split('-');
    if (parts.length == 1) {
      return Locale(parts[0]);
    }
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    }
    return null;
  }

  static String _localeToTag(Locale locale) {
    if (locale.countryCode == null || locale.countryCode!.isEmpty) {
      return locale.languageCode;
    }
    return '${locale.languageCode}-${locale.countryCode}';
  }

  static bool _isSupported(Locale locale) {
    return supportedLocales.any(
      (supported) =>
          supported.languageCode == locale.languageCode &&
          supported.countryCode == locale.countryCode,
    );
  }
}
