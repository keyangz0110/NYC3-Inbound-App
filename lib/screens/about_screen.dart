import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants/app_info.dart';
import '../l10n/app_localizations.dart';
import '../services/update_service.dart';
import '../services/update_settings_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    super.key,
    required this.updateSettings,
    required this.updateService,
  });

  final UpdateSettingsService updateSettings;
  final UpdateService updateService;

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool _checking = false;
  bool _downloading = false;
  double? _downloadProgress;

  Future<PackageInfo> _loadPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  void _showToast(String message, {required bool isError}) {
    FToast().init(context).showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isError
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  Future<void> _checkForUpdate() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _checking = true;
      _downloadProgress = null;
    });

    try {
      final result = await widget.updateService.checkForUpdate();
      if (!mounted) {
        return;
      }

      switch (result.status) {
        case UpdateCheckStatus.notConfigured:
          _showToast(l10n.updateUrlNotConfigured, isError: true);
        case UpdateCheckStatus.upToDate:
          _showToast(l10n.updateUpToDate, isError: false);
        case UpdateCheckStatus.error:
          _showToast(
            l10n.updateCheckFailed(result.message ?? ''),
            isError: true,
          );
        case UpdateCheckStatus.updateAvailable:
          final remote = result.remote!;
          final shouldUpdate = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(l10n.updateAvailableTitle),
              content: Text(
                [
                  l10n.updateAvailableContent(
                    result.currentVersionName ?? '—',
                    remote.versionName,
                  ),
                  if (remote.releaseNotes != null &&
                      remote.releaseNotes!.trim().isNotEmpty) ...[
                    '',
                    remote.releaseNotes!.trim(),
                  ],
                ].join('\n'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(l10n.downloadAndInstall),
                ),
              ],
            ),
          );

          if (shouldUpdate == true && mounted) {
            await _downloadAndInstall(remote);
          }
      }
    } finally {
      if (mounted) {
        setState(() => _checking = false);
      }
    }
  }

  Future<void> _downloadAndInstall(AppUpdateInfo update) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _downloading = true;
      _downloadProgress = 0;
    });

    try {
      await widget.updateService.downloadAndInstall(
        update,
        onProgress: (received, total) {
          if (!mounted) {
            return;
          }
          setState(() {
            _downloadProgress =
                total != null && total > 0 ? received / total : null;
          });
        },
      );
      if (mounted) {
        _showToast(l10n.updateInstallPrompt, isError: false);
      }
    } catch (e) {
      if (mounted) {
        _showToast(l10n.updateInstallFailed(e.toString()), isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _downloading = false;
          _downloadProgress = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final busy = _checking || _downloading;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
      ),
      body: FutureBuilder<PackageInfo>(
        future: _loadPackageInfo(),
        builder: (context, snapshot) {
          final version = snapshot.data?.version ?? '—';
          final buildNumber = snapshot.data?.buildNumber;

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 72,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.appTitle,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.versionLabel),
                subtitle: Text(
                  buildNumber == null ? version : '$version ($buildNumber)',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(l10n.authorLabel),
                subtitle: Text(
                  AppInfo.authorName,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                leading: busy
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.system_update),
                title: Text(l10n.checkForUpdate),
                subtitle: Text(
                  _downloading
                      ? (_downloadProgress == null
                          ? l10n.updateDownloading
                          : l10n.updateDownloadProgress(
                              (_downloadProgress! * 100).round(),
                            ))
                      : l10n.checkForUpdateSubtitle,
                ),
                enabled: !busy,
                onTap: busy ? null : _checkForUpdate,
              ),
              if (_downloading && _downloadProgress != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LinearProgressIndicator(value: _downloadProgress),
                ),
            ],
          );
        },
      ),
    );
  }
}
