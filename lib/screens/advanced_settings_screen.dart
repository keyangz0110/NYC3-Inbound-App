import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../l10n/app_localizations.dart';
import '../services/export_service.dart';
import '../services/update_settings_service.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  const AdvancedSettingsScreen({
    super.key,
    required this.exportService,
    required this.updateSettings,
  });

  final ExportService exportService;
  final UpdateSettingsService updateSettings;

  @override
  State<AdvancedSettingsScreen> createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.updateSettings.manifestUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _showToast(String message, {bool isError = false}) {
    final theme = Theme.of(context);
    FToast().init(context).showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isError ? theme.colorScheme.error : theme.colorScheme.primary,
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

  Future<void> _exportHistory() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final result = await widget.exportService.exportHistory();
      if (mounted) {
        _showToast(l10n.exportHistorySuccess(result.path));
      }
    } on StateError catch (e) {
      if (e.message == 'empty' && mounted) {
        _showToast(l10n.exportHistoryEmpty, isError: true);
      }
    } catch (e) {
      if (mounted) {
        _showToast(l10n.exportHistoryFailed(e.toString()), isError: true);
      }
    }
  }

  Future<void> _saveUpdateUrl() async {
    final l10n = AppLocalizations.of(context)!;
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
        _showToast(l10n.invalidUpdateUrl, isError: true);
        return;
      }
    }

    await widget.updateSettings.setManifestUrl(url);
    if (mounted) {
      _showToast(l10n.updateUrlSaved);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.advanced),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.upload_file),
            title: Text(l10n.exportHistory),
            trailing: const Icon(Icons.chevron_right),
            onTap: _exportHistory,
          ),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            l10n.updateServerUrl,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.updateServerUrlHint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              hintText: l10n.updateServerUrlExample,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: _saveUpdateUrl,
              child: Text(l10n.saveUpdateUrl),
            ),
          ),
        ],
      ),
    );
  }
}
