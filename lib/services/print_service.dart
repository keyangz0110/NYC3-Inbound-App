import 'package:zebra_printer/zebra_printer.dart';

import '../l10n/app_localizations.dart';
import 'bluetooth_permission_helper.dart';
import 'network_zebra_printer.dart';
import 'printer_settings_service.dart';
import 'sort_storage_service.dart';
import 'zpl_label_builder.dart';

enum PrintFailureReason {
  noPrinter,
  noSlots,
  permissionDenied,
  printerNotReady,
  error,
}

class PrintResult {
  const PrintResult({
    required this.success,
    this.labelCount = 0,
    this.reason,
    this.message,
  });

  final bool success;
  final int labelCount;
  final PrintFailureReason? reason;
  final String? message;
}

typedef PrintProgressCallback = void Function(int current, int total);

class PrintService {
  PrintService({
    required this.storage,
    required this.printerSettings,
  });

  final SortStorageService storage;
  final PrinterSettingsService printerSettings;

  final PrinterManager _printerManager = PrinterManager();

  /// Discovers Bluetooth printers. Requires Bluetooth/location permissions.
  Future<List<DiscoveredPrinter>> discoverBluetoothPrinters() async {
    final granted = await BluetoothPermissionHelper.ensureGranted();
    if (!granted) {
      throw StateError('Bluetooth permission denied');
    }

    return _printerManager.startDiscovery(type: DiscoveryType.bluetooth);
  }

  /// Discovers Wi-Fi / network printers on the local LAN.
  ///
  /// Note: the zebra_printer SDK's [DiscoveryType.both] only runs Bluetooth
  /// discovery, so network discovery must be called separately.
  Future<List<DiscoveredPrinter>> discoverNetworkPrinters() async {
    return _printerManager.startDiscovery(type: DiscoveryType.network);
  }

  /// Runs Bluetooth then network discovery and merges unique addresses.
  Future<List<DiscoveredPrinter>> discoverAllPrinters() async {
    final results = <DiscoveredPrinter>[];
    final seen = <String>{};

    try {
      final bluetooth = await discoverBluetoothPrinters();
      for (final printer in bluetooth) {
        if (seen.add(printer.address)) {
          results.add(printer);
        }
      }
    } on StateError {
      rethrow;
    } catch (_) {
      // Continue with network discovery even if Bluetooth fails.
    }

    try {
      final network = await discoverNetworkPrinters();
      for (final printer in network) {
        if (seen.add(printer.address)) {
          results.add(printer);
        }
      }
    } catch (_) {
      // Keep any Bluetooth results already found.
    }

    return results;
  }

  Future<PrintResult> printTestLabel() async {
    final address = printerSettings.address;
    if (address == null || address.isEmpty) {
      return const PrintResult(
        success: false,
        reason: PrintFailureReason.noPrinter,
      );
    }

    final permissionError = await _ensurePrintPermissions();
    if (permissionError != null) {
      return permissionError;
    }

    try {
      if (_useNetworkPrint) {
        final host = NetworkZebraPrinter.hostFromAddress(address);
        final port = NetworkZebraPrinter.portFromAddress(address);
        final reachable = await NetworkZebraPrinter.canReach(host, port: port);
        if (!reachable) {
          return const PrintResult(
            success: false,
            reason: PrintFailureReason.printerNotReady,
          );
        }
        await NetworkZebraPrinter.printZpl(
          host,
          ZplLabelBuilder.buildTestLabel(),
          port: port,
        );
        return const PrintResult(success: true, labelCount: 1);
      }

      final ready = await _printerManager.canPrint(address);
      if (!ready) {
        return const PrintResult(
          success: false,
          reason: PrintFailureReason.printerNotReady,
        );
      }

      await _printerManager.safePrint(address, ZplLabelBuilder.buildTestLabel());
      return const PrintResult(success: true, labelCount: 1);
    } catch (e) {
      return PrintResult(
        success: false,
        reason: PrintFailureReason.error,
        message: e.toString(),
      );
    }
  }

  Future<PrintResult> printCartonLabels({
    required String cartonId,
    required AppLocalizations l10n,
    PrintProgressCallback? onProgress,
  }) async {
    final address = printerSettings.address;
    if (address == null || address.isEmpty) {
      return const PrintResult(
        success: false,
        reason: PrintFailureReason.noPrinter,
      );
    }

    final carton = storage.getCartonById(cartonId);
    if (carton == null) {
      return PrintResult(
        success: false,
        reason: PrintFailureReason.error,
        message: 'Carton not found',
      );
    }

    final slots = storage.getSlotsForCarton(cartonId);
    if (slots.isEmpty) {
      return const PrintResult(
        success: false,
        reason: PrintFailureReason.noSlots,
      );
    }

    final permissionError = await _ensurePrintPermissions();
    if (permissionError != null) {
      return permissionError;
    }

    final captions = ZplLabelCaptions(
      slot: l10n.slotLabel,
      carton: l10n.cartonBarcodeLabel,
      product: l10n.productBarcodeLabel,
      quantity: l10n.quantityLabel,
    );

    final zplList = slots
        .map(
          (slot) => ZplLabelBuilder.buildSlotLabel(
            data: SlotLabelData(
              slotNumber: slot.slot,
              cartonBarcode: carton.ibrBarcode,
              productBarcode: slot.productBarcode,
              quantity: slot.quantity,
            ),
            captions: captions,
          ),
        )
        .toList();

    try {
      if (_useNetworkPrint) {
        final host = NetworkZebraPrinter.hostFromAddress(address);
        final port = NetworkZebraPrinter.portFromAddress(address);
        final reachable = await NetworkZebraPrinter.canReach(host, port: port);
        if (!reachable) {
          return const PrintResult(
            success: false,
            reason: PrintFailureReason.printerNotReady,
          );
        }

        onProgress?.call(0, zplList.length);
        await NetworkZebraPrinter.printZplBatch(
          host,
          zplList,
          port: port,
          onProgress: onProgress,
        );
        onProgress?.call(zplList.length, zplList.length);
        return PrintResult(success: true, labelCount: zplList.length);
      }

      final progressHandler = onProgress;
      void Function(PrintProgress progress)? previousHandler;

      if (progressHandler != null) {
        previousHandler = _printerManager.onPrintProgress;
        _printerManager.onPrintProgress = (progress) {
          previousHandler?.call(progress);
          if (progress.isBatch &&
              progress.currentLabel != null &&
              progress.totalLabels != null) {
            progressHandler(progress.currentLabel!, progress.totalLabels!);
          }
        };
      }

      try {
        final ready = await _printerManager.canPrint(address);
        if (!ready) {
          return const PrintResult(
            success: false,
            reason: PrintFailureReason.printerNotReady,
          );
        }

        onProgress?.call(0, zplList.length);
        await _printerManager.safeBatchPrint(address, zplList);
        onProgress?.call(zplList.length, zplList.length);
        return PrintResult(success: true, labelCount: zplList.length);
      } finally {
        if (progressHandler != null) {
          _printerManager.onPrintProgress = previousHandler;
        }
      }
    } catch (e) {
      return PrintResult(
        success: false,
        reason: PrintFailureReason.error,
        message: e.toString(),
      );
    }
  }

  String messageForResult(PrintResult result, AppLocalizations l10n) {
    return switch (result.reason) {
      PrintFailureReason.noPrinter => l10n.noPrinterConfigured,
      PrintFailureReason.noSlots => l10n.noSlotsToPrint,
      PrintFailureReason.permissionDenied => l10n.bluetoothPermissionRequired,
      PrintFailureReason.printerNotReady => l10n.printerNotReady,
      PrintFailureReason.error => l10n.printFailed(result.message ?? ''),
      null => result.success
          ? l10n.printSuccess(result.labelCount)
          : l10n.printFailed(''),
    };
  }

  bool get _useNetworkPrint {
    if (printerSettings.connectionType.isNetwork) {
      return true;
    }
    final address = printerSettings.address;
    return address != null && NetworkZebraPrinter.isNetworkAddress(address);
  }

  /// Bluetooth printers need BT permissions; network printers do not.
  Future<PrintResult?> _ensurePrintPermissions() async {
    if (_useNetworkPrint) {
      return null;
    }

    final granted = await BluetoothPermissionHelper.ensureGranted();
    if (!granted) {
      return const PrintResult(
        success: false,
        reason: PrintFailureReason.permissionDenied,
      );
    }
    return null;
  }
}
