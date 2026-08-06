import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../l10n/app_localizations.dart';
import '../services/display_settings_service.dart';
import '../services/export_service.dart';
import '../services/locale_service.dart';
import '../services/print_service.dart';
import '../services/printer_settings_service.dart';
import '../services/theme_service.dart';
import '../services/update_service.dart';
import '../services/update_settings_service.dart';
import 'about_screen.dart';
import 'advanced_settings_screen.dart';
import 'printer_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.localeService,
    required this.themeService,
    required this.displaySettingsService,
    required this.exportService,
    required this.printerSettings,
    required this.printService,
    required this.updateSettings,
    required this.updateService,
  });

  final LocaleService localeService;
  final ThemeService themeService;
  final DisplaySettingsService displaySettingsService;
  final ExportService exportService;
  final PrinterSettingsService printerSettings;
  final PrintService printService;
  final UpdateSettingsService updateSettings;
  final UpdateService updateService;

  String _languageLabel(AppLocalizations l10n, Locale locale) {
    return switch ('${locale.languageCode}_${locale.countryCode}') {
      'en_US' => l10n.languageEnUs,
      'es_419' => l10n.languageEs419,
      'zh_CN' => l10n.languageZhCn,
      'id_ID' => l10n.languageIdId,
      'fr_FR' => l10n.languageFrFr,
      _ => locale.toLanguageTag(),
    };
  }

  String _themeLabel(AppLocalizations l10n, AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => l10n.themeSystem,
      AppThemeMode.light => l10n.themeLight,
      AppThemeMode.dark => l10n.themeDark,
    };
  }

  Future<void> _showLanguagePicker(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 12),
              Text(l10n.language),
            ],
          ),
          content: RadioGroup<Locale>(
            groupValue: localeService.locale,
            onChanged: (locale) async {
              if (locale == null) {
                return;
              }
              await localeService.setLocale(locale);
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: LocaleService.supportedLocales.map((locale) {
                return RadioListTile<Locale>(
                  value: locale,
                  title: Text(_languageLabel(l10n, locale)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showThemePicker(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.palette_outlined),
              const SizedBox(width: 12),
              Text(l10n.theme),
            ],
          ),
          content: RadioGroup<AppThemeMode>(
            groupValue: themeService.themeMode,
            onChanged: (mode) async {
              if (mode == null) {
                return;
              }
              await themeService.setThemeMode(mode);
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: AppThemeMode.values.map((mode) {
                return RadioListTile<AppThemeMode>(
                  value: mode,
                  title: Text(_themeLabel(l10n, mode)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          localeService,
          themeService,
          displaySettingsService,
          printerSettings,
        ]),
        builder: (context, _) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.language),
                subtitle: Text(_languageLabel(l10n, localeService.locale)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLanguagePicker(context),
              ),
              ListTile(
                leading: const Icon(Icons.palette_outlined),
                title: Text(l10n.theme),
                subtitle: Text(_themeLabel(l10n, themeService.themeMode)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showThemePicker(context),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.inventory_2_outlined),
                title: Text(l10n.displayQuantityOnSortScreen),
                value: displaySettingsService.displayQuantityOnSortScreen,
                onChanged: displaySettingsService.setDisplayQuantityOnSortScreen,
              ),
              ListTile(
                leading: const Icon(Icons.print_outlined),
                title: Text(l10n.printer),
                subtitle: Text(
                  printerSettings.hasPrinter
                      ? printerSettings.name ?? printerSettings.address!
                      : l10n.noPrinterConfigured,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => PrinterSettingsScreen(
                        printerSettings: printerSettings,
                        printService: printService,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Symbols.code_xml),
                title: Text(l10n.advanced),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => AdvancedSettingsScreen(
                        exportService: exportService,
                        updateSettings: updateSettings,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.about),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => AboutScreen(
                        updateSettings: updateSettings,
                        updateService: updateService,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
