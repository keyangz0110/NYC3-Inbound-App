import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplaySettingsService extends ChangeNotifier {
  DisplaySettingsService();

  static const String _prefsKey = 'display_quantity_on_sort_screen';
  static const String _legacyPrefsKey = 'hide_quantity_on_sort_screen';

  bool _displayQuantityOnSortScreen = true;

  bool get displayQuantityOnSortScreen => _displayQuantityOnSortScreen;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_prefsKey)) {
      _displayQuantityOnSortScreen = prefs.getBool(_prefsKey) ?? true;
    } else if (prefs.containsKey(_legacyPrefsKey)) {
      final hide = prefs.getBool(_legacyPrefsKey) ?? true;
      _displayQuantityOnSortScreen = !hide;
      await prefs.setBool(_prefsKey, _displayQuantityOnSortScreen);
    } else {
      _displayQuantityOnSortScreen = true;
    }
    notifyListeners();
  }

  Future<void> setDisplayQuantityOnSortScreen(bool value) async {
    _displayQuantityOnSortScreen = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, value);
  }
}
