import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zebra_printer/zebra_printer.dart';

import '../l10n/app_localizations.dart';
import '../services/print_service.dart';
import '../services/printer_settings_service.dart';

class PrinterSettingsScreen extends StatefulWidget {
  const PrinterSettingsScreen({
    super.key,
    required this.printerSettings,
    required this.printService,
  });

  final PrinterSettingsService printerSettings;
  final PrintService printService;

  @override
  State<PrinterSettingsScreen> createState() => _PrinterSettingsScreenState();
}

class _PrinterSettingsScreenState extends State<PrinterSettingsScreen> {
  List<DiscoveredPrinter> _discoveredPrinters = const [];
  bool _isDiscovering = false;
  bool _isTestPrinting = false;
  String? _statusMessage;
  PrinterConnectionType _discoveryMode = PrinterConnectionType.bluetooth;

  final TextEditingController _ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.printerSettings.hasPrinter) {
      _discoveryMode = widget.printerSettings.connectionType;
      if (widget.printerSettings.connectionType.isNetwork) {
        _ipController.text = widget.printerSettings.address ?? '';
      }
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final selected = widget.printerSettings;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.printerSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.printerSetupHelp,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.connectionType,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SegmentedButton<PrinterConnectionType>(
            segments: [
              ButtonSegment(
                value: PrinterConnectionType.bluetooth,
                label: Text(l10n.connectionBluetooth),
                icon: const Icon(Icons.bluetooth),
              ),
              ButtonSegment(
                value: PrinterConnectionType.network,
                label: Text(l10n.connectionWifi),
                icon: const Icon(Icons.wifi),
              ),
            ],
            selected: {_discoveryMode},
            onSelectionChanged: (selection) {
              setState(() {
                _discoveryMode = selection.first;
                _discoveredPrinters = const [];
                _statusMessage = null;
              });
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              selected.connectionType.isNetwork ? Icons.wifi : Icons.bluetooth,
            ),
            title: Text(l10n.selectPrinter),
            subtitle: Text(
              selected.hasPrinter
                  ? '${selected.name ?? selected.address!}'
                      '${selected.connectionType.isNetwork ? ' (${l10n.connectionWifi})' : ' (${l10n.connectionBluetooth})'}'
                  : l10n.noPrinterConfigured,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _isDiscovering ? null : _discoverPrinters,
              icon: _isDiscovering
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      _discoveryMode.isNetwork
                          ? Icons.wifi_find
                          : Icons.bluetooth_searching,
                    ),
              label: Text(
                _isDiscovering
                    ? l10n.discoveringPrinters
                    : (_discoveryMode.isNetwork
                        ? l10n.discoverWifiPrinters
                        : l10n.discoverBluetoothPrinters),
              ),
            ),
          ),
          if (_discoveryMode.isNetwork) ...[
            const SizedBox(height: 20),
            Text(
              l10n.enterPrinterIp,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.enterPrinterIpHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _ipController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: l10n.printerIpHint,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _saveManualIp,
                  child: Text(l10n.savePrinterIp),
                ),
              ],
            ),
          ],
          if (_statusMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _statusMessage!,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ],
          const SizedBox(height: 16),
          if (_discoveredPrinters.isEmpty && !_isDiscovering)
            Text(
              l10n.noPrintersFound,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ..._discoveredPrinters.map((printer) {
            final isSelected = selected.address == printer.address;
            final isNetwork = printer.type.toLowerCase() == 'network';
            return Card(
              child: ListTile(
                leading: Icon(
                  isNetwork ? Icons.wifi : Icons.bluetooth,
                  color: isSelected ? theme.colorScheme.primary : null,
                ),
                title: Text(
                  printer.friendlyName.isEmpty ? printer.address : printer.friendlyName,
                ),
                subtitle: Text(
                  '${printer.address} · ${isNetwork ? l10n.connectionWifi : l10n.connectionBluetooth}',
                ),
                trailing: isSelected
                    ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
                    : null,
                onTap: () => _selectPrinter(printer),
              ),
            );
          }),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: selected.hasPrinter && !_isTestPrinting ? _testPrint : null,
              icon: _isTestPrinting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.print),
              label: Text(l10n.testPrint),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _discoverPrinters() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isDiscovering = true;
      _statusMessage = null;
      _discoveredPrinters = const [];
    });

    try {
      final printers = _discoveryMode.isNetwork
          ? await widget.printService.discoverNetworkPrinters()
          : await widget.printService.discoverBluetoothPrinters();
      if (!mounted) {
        return;
      }
      setState(() {
        _discoveredPrinters = printers;
        if (printers.isEmpty) {
          _statusMessage = l10n.noPrintersFound;
        }
      });
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      final message = e.toString();
      setState(() {
        _statusMessage = message.contains('permission') || message.contains('Permission')
            ? l10n.bluetoothPermissionRequired
            : l10n.printFailed(message);
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _statusMessage = l10n.printFailed(e.toString());
      });
    } finally {
      if (mounted) {
        setState(() => _isDiscovering = false);
      }
    }
  }

  Future<void> _selectPrinter(DiscoveredPrinter printer) async {
    final l10n = AppLocalizations.of(context)!;
    final isNetwork = printer.type.toLowerCase() == 'network';
    final name = printer.friendlyName.isEmpty ? printer.address : printer.friendlyName;

    await widget.printerSettings.setPrinter(
      address: printer.address,
      name: name,
      connectionType: isNetwork
          ? PrinterConnectionType.network
          : PrinterConnectionType.bluetooth,
    );

    if (isNetwork) {
      _ipController.text = printer.address;
    }

    if (!mounted) {
      return;
    }
    _showToast(l10n.printerSaved(name), isError: false);
    setState(() {});
  }

  Future<void> _saveManualIp() async {
    final l10n = AppLocalizations.of(context)!;
    final ip = _ipController.text.trim();

    if (!_isValidIpv4(ip)) {
      setState(() => _statusMessage = l10n.invalidPrinterIp);
      return;
    }

    final name = 'ZQ521 ($ip)';
    await widget.printerSettings.setPrinter(
      address: ip,
      name: name,
      connectionType: PrinterConnectionType.network,
    );

    if (!mounted) {
      return;
    }
    setState(() {
      _statusMessage = null;
      _discoveryMode = PrinterConnectionType.network;
    });
    _showToast(l10n.printerSaved(name), isError: false);
  }

  Future<void> _testPrint() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isTestPrinting = true);
    try {
      final result = await widget.printService.printTestLabel();
      if (!mounted) {
        return;
      }
      _showToast(
        widget.printService.messageForResult(result, l10n),
        isError: !result.success,
      );
    } finally {
      if (mounted) {
        setState(() => _isTestPrinting = false);
      }
    }
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

  static bool _isValidIpv4(String value) {
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
