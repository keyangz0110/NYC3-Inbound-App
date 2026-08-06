import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color(0xFF1976D2);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );

    return _baseTheme(colorScheme);
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
      surface: const Color(0xFF1A1C1E),
    );

    return _baseTheme(colorScheme);
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18),
        bodyMedium: TextStyle(fontSize: 16),
      ),
      dividerColor: colorScheme.outlineVariant,
      useMaterial3: true,
    );
  }
}

extension AppThemeColors on ThemeData {
  Color get mutedText => colorScheme.onSurfaceVariant;

  Color get emptyCodeText => colorScheme.onSurface.withValues(alpha: 0.38);

  Color get successText =>
      brightness == Brightness.dark ? const Color(0xFF81C784) : const Color(0xFF2E7D32);

  Color get warningText =>
      brightness == Brightness.dark ? const Color(0xFFFFB74D) : const Color(0xFFE65100);

  Color get destructiveColor => colorScheme.error;

  Color get destructiveBorder => colorScheme.error.withValues(alpha: 0.55);

  Color get slotSquareBackground =>
      brightness == Brightness.dark ? const Color(0xFF1B5E20) : const Color(0xFFE8F5E9);

  Color get slotSquareForeground =>
      brightness == Brightness.dark ? const Color(0xFFA5D6A7) : const Color(0xFF2E7D32);

  Color get closedSlotSquareBackground =>
      brightness == Brightness.dark ? const Color(0xFF4A1C1C) : const Color(0xFFFFEBEE);

  Color get closedSlotSquareForeground =>
      brightness == Brightness.dark ? const Color(0xFFEF9A9A) : const Color(0xFFC62828);

  Color get quantitySquareBackground =>
      brightness == Brightness.dark ? const Color(0xFF0D47A1) : const Color(0xFFE3F2FD);

  Color get quantitySquareForeground =>
      brightness == Brightness.dark ? const Color(0xFF90CAF9) : const Color(0xFF1565C0);

  Color get barcodeSquareBackground =>
      brightness == Brightness.dark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5);

  Color get barcodeSquareForeground => colorScheme.onSurface;
}
