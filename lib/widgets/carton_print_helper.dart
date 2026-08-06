import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/print_service.dart';

Future<PrintResult> runCartonPrint(
  BuildContext context,
  PrintService printService,
  String cartonId,
) async {
  final l10n = AppLocalizations.of(context)!;
  final progressNotifier = ValueNotifier<(int current, int total)>((0, 0));

  if (!context.mounted) {
    return const PrintResult(success: false, reason: PrintFailureReason.error);
  }

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return ValueListenableBuilder<(int, int)>(
        valueListenable: progressNotifier,
        builder: (context, value, _) {
          final current = value.$1;
          final total = value.$2;
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(l10n.printingLabels),
                if (total > 0) ...[
                  const SizedBox(height: 8),
                  Text(l10n.printProgress(current, total)),
                ],
              ],
            ),
          );
        },
      );
    },
  );

  final result = await printService.printCartonLabels(
    cartonId: cartonId,
    l10n: l10n,
    onProgress: (current, total) {
      progressNotifier.value = (current, total);
    },
  );

  progressNotifier.dispose();

  if (context.mounted) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  return result;
}

String printResultMessage(PrintResult result, AppLocalizations l10n) {
  if (result.success) {
    return l10n.printSuccess(result.labelCount);
  }
  return switch (result.reason) {
    PrintFailureReason.noPrinter => l10n.noPrinterConfigured,
    PrintFailureReason.noSlots => l10n.noSlotsToPrint,
    PrintFailureReason.permissionDenied => l10n.bluetoothPermissionRequired,
    PrintFailureReason.printerNotReady => l10n.printerNotReady,
    PrintFailureReason.error => l10n.printFailed(result.message ?? ''),
    null => l10n.printFailed(''),
  };
}
