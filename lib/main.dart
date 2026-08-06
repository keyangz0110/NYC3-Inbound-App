import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'models/carton.dart';
import 'screens/manage_tab.dart';
import 'screens/settings_screen.dart';
import 'screens/sort_tab.dart';
import 'services/display_settings_service.dart';
import 'services/export_service.dart';
import 'services/locale_service.dart';
import 'services/print_service.dart';
import 'services/printer_settings_service.dart';
import 'services/sort_storage_service.dart';
import 'services/sound_service.dart';
import 'services/theme_service.dart';
import 'services/update_service.dart';
import 'services/update_settings_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localeService = LocaleService();
  final themeService = ThemeService();
  final displaySettingsService = DisplaySettingsService();
  final printerSettingsService = PrinterSettingsService();
  final updateSettingsService = UpdateSettingsService();
  await Future.wait([
    localeService.load(),
    themeService.load(),
    displaySettingsService.load(),
    printerSettingsService.load(),
    updateSettingsService.load(),
  ]);
  runApp(SortingApp(
    localeService: localeService,
    themeService: themeService,
    displaySettingsService: displaySettingsService,
    printerSettingsService: printerSettingsService,
    updateSettingsService: updateSettingsService,
  ));
}

class SortingApp extends StatelessWidget {
  const SortingApp({
    super.key,
    required this.localeService,
    required this.themeService,
    required this.displaySettingsService,
    required this.printerSettingsService,
    required this.updateSettingsService,
  });

  final LocaleService localeService;
  final ThemeService themeService;
  final DisplaySettingsService displaySettingsService;
  final PrinterSettingsService printerSettingsService;
  final UpdateSettingsService updateSettingsService;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        localeService,
        themeService,
        displaySettingsService,
        printerSettingsService,
        updateSettingsService,
      ]),
      builder: (context, _) {
        return MaterialApp(
          title: 'Sorting',
          locale: localeService.locale,
          themeMode: themeService.materialThemeMode,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomeScreen(
            localeService: localeService,
            themeService: themeService,
            displaySettingsService: displaySettingsService,
            printerSettingsService: printerSettingsService,
            updateSettingsService: updateSettingsService,
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.localeService,
    required this.themeService,
    required this.displaySettingsService,
    required this.printerSettingsService,
    required this.updateSettingsService,
  });

  final LocaleService localeService;
  final ThemeService themeService;
  final DisplaySettingsService displaySettingsService;
  final PrinterSettingsService printerSettingsService;
  final UpdateSettingsService updateSettingsService;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final SortStorageService _storage = SortStorageService();
  final SoundService _soundService = SoundService();
  late final ExportService _exportService;
  late final PrintService _printService;
  late final UpdateService _updateService;
  late final TabController _tabController;
  bool _loaded = false;
  bool _tabBarExpanded = true;
  Timer? _tabBarFoldTimer;

  static const Duration _tabBarFoldDelay = Duration(seconds: 5);
  static const double _tabBarHeight = 48;

  @override
  void initState() {
    super.initState();
    _exportService = ExportService(storage: _storage);
    _printService = PrintService(
      storage: _storage,
      printerSettings: widget.printerSettingsService,
    );
    _updateService = UpdateService(
      updateSettings: widget.updateSettingsService,
    );
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadStorage();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scheduleTabBarFold());
  }

  Future<void> _loadStorage() async {
    await _storage.load();
    if (mounted) {
      setState(() => _loaded = true);
    }
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      _scheduleTabBarFold();
      setState(() {});
    }
  }

  void _scheduleTabBarFold() {
    _tabBarFoldTimer?.cancel();
    if (!_tabBarExpanded) {
      setState(() => _tabBarExpanded = true);
    }
    _tabBarFoldTimer = Timer(_tabBarFoldDelay, () {
      if (mounted) {
        setState(() => _tabBarExpanded = false);
      }
    });
  }

  void _expandTabBar() {
    _scheduleTabBarFold();
  }

  @override
  void dispose() {
    _tabBarFoldTimer?.cancel();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _soundService.dispose();
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final cartons = _storage.getCartons();

    return ListenableBuilder(
      listenable: widget.displaySettingsService,
      builder: (context, _) {
        return _buildScaffold(context, l10n, theme, cartons);
      },
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    List<Carton> cartons,
  ) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _tabBarExpanded ? null : _expandTabBar,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (!_tabBarExpanded) ...[
                const SizedBox(width: 8),
                Icon(Icons.expand_more, size: 22, color: theme.colorScheme.onSurfaceVariant),
              ],
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => SettingsScreen(
                    localeService: widget.localeService,
                    themeService: widget.themeService,
                    displaySettingsService: widget.displaySettingsService,
                    exportService: _exportService,
                    printerSettings: widget.printerSettingsService,
                    printService: _printService,
                    updateSettings: widget.updateSettingsService,
                    updateService: _updateService,
                  ),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_tabBarExpanded ? _tabBarHeight : 0),
          child: ClipRect(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              heightFactor: _tabBarExpanded ? 1 : 0,
              child: TabBar(
                controller: _tabController,
                onTap: (_) => _scheduleTabBarFold(),
                tabs: [
                  Tab(text: l10n.sortTab, icon: const Icon(Icons.qr_code_scanner)),
                  Tab(text: l10n.manageTab, icon: const Icon(Icons.inventory_2_outlined)),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SortTab(
            storage: _storage,
            soundService: _soundService,
            printService: _printService,
            onDataChanged: _refresh,
            tabController: _tabController,
            toastContext: context,
            tabBarFolded: !_tabBarExpanded,
            displayQuantityOnSortScreen:
                widget.displaySettingsService.displayQuantityOnSortScreen,
          ),
          ManageTab(
            storage: _storage,
            soundService: _soundService,
            printService: _printService,
            cartons: cartons,
            onDataChanged: _refresh,
          ),
        ],
      ),
    );
  }
}
