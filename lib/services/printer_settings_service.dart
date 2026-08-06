import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrinterConnectionType {
  bluetooth,
  network;

  static PrinterConnectionType fromStorage(String? value) {
    return switch (value) {
      'network' => PrinterConnectionType.network,
      _ => PrinterConnectionType.bluetooth,
    };
  }

  String get storageValue => name;

  bool get isNetwork => this == PrinterConnectionType.network;
  bool get isBluetooth => this == PrinterConnectionType.bluetooth;
}

class PrinterSettingsService extends ChangeNotifier {
  PrinterSettingsService();

  static const String _addressKey = 'printer_address';
  static const String _nameKey = 'printer_name';
  static const String _connectionTypeKey = 'printer_connection_type';

  String? _address;
  String? _name;
  PrinterConnectionType _connectionType = PrinterConnectionType.bluetooth;

  String? get address => _address;
  String? get name => _name;
  PrinterConnectionType get connectionType => _connectionType;
  bool get hasPrinter => _address != null && _address!.isNotEmpty;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _address = prefs.getString(_addressKey);
    _name = prefs.getString(_nameKey);
    _connectionType = PrinterConnectionType.fromStorage(
      prefs.getString(_connectionTypeKey),
    );
    // Infer network for legacy saves that stored an IPv4 address without a type.
    if (_connectionType == PrinterConnectionType.bluetooth &&
        _address != null &&
        _looksLikeIpv4(_address!)) {
      _connectionType = PrinterConnectionType.network;
    }
    notifyListeners();
  }

  Future<void> setPrinter({
    required String address,
    required String name,
    required PrinterConnectionType connectionType,
  }) async {
    _address = address.trim();
    _name = name.trim();
    _connectionType = connectionType;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_addressKey, _address!);
    await prefs.setString(_nameKey, _name!);
    await prefs.setString(_connectionTypeKey, connectionType.storageValue);
  }

  Future<void> clear() async {
    _address = null;
    _name = null;
    _connectionType = PrinterConnectionType.bluetooth;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_addressKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_connectionTypeKey);
  }

  static bool _looksLikeIpv4(String value) {
    final parts = value.split('.');
    if (parts.length != 4) {
      return false;
    }
    for (final part in parts) {
      final n = int.tryParse(part);
      if (n == null || n < 0 || n > 255) {
        return false;
      }
    }
    return true;
  }
}
