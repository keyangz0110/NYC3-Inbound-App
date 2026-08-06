import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/update_config.dart';

class UpdateSettingsService extends ChangeNotifier {
  UpdateSettingsService();

  static const String _manifestUrlKey = 'update_manifest_url';

  String _manifestUrl = UpdateConfig.defaultManifestUrl;

  String get manifestUrl => _manifestUrl;

  bool get hasManifestUrl => _manifestUrl.trim().isNotEmpty;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _manifestUrl =
        prefs.getString(_manifestUrlKey) ?? UpdateConfig.defaultManifestUrl;
    notifyListeners();
  }

  Future<void> setManifestUrl(String url) async {
    _manifestUrl = url.trim();
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    if (_manifestUrl.isEmpty) {
      await prefs.remove(_manifestUrlKey);
    } else {
      await prefs.setString(_manifestUrlKey, _manifestUrl);
    }
  }
}
