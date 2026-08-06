import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/slot.dart';
import '../services/sort_storage_service.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import '../widgets/info_square.dart';

class SlotDetailScreen extends StatefulWidget {
  const SlotDetailScreen({
    super.key,
    required this.storage,
    required this.soundService,
    required this.cartonId,
    required this.slotId,
    required this.onDataChanged,
  });

  final SortStorageService storage;
  final SoundService soundService;
  final String cartonId;
  final String slotId;
  final VoidCallback onDataChanged;

  @override
  State<SlotDetailScreen> createState() => _SlotDetailScreenState();
}

class _SlotDetailScreenState extends State<SlotDetailScreen> {
  Slot? get _slot {
    final carton = widget.storage.getCartonById(widget.cartonId);
    if (carton == null) {
      return null;
    }
    for (final slot in carton.slots) {
      if (slot.id == widget.slotId) {
        return slot;
      }
    }
    return null;
  }

  Future<void> _confirmCloseSlot(Slot slot) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.closeSlotTitle),
        content: Text(l10n.closeSlotContent(slot.slot)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.closeSlot),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.storage.closeSlot(widget.cartonId, slot.id);
      await widget.soundService.play(SoundEvent.slotClosed);
      widget.onDataChanged();
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _confirmUndo(Slot slot) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.undoProductTitle),
        content: Text(l10n.undoProductContent(slot.slot)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.undoProduct),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.storage.undoProductScan(widget.cartonId, slot.id);
      widget.onDataChanged();
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _confirmDelete(Slot slot) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteProductTitle),
        content: Text(l10n.deleteProductContent(slot.slot)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.storage.deleteProduct(widget.cartonId, slot.id);
      widget.onDataChanged();
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final slot = _slot;

    if (slot == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.noSearchResults)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.slotLabel} ${slot.slot}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                InfoSquare(
                  icon: Icons.grid_view,
                  label: l10n.slotLabel,
                  value: slot.slot,
                  backgroundColor: theme.slotSquareBackground,
                  foregroundColor: theme.slotSquareForeground,
                ),
                const SizedBox(width: 12),
                InfoSquare(
                  icon: Icons.inventory_2_outlined,
                  label: l10n.quantityLabel,
                  value: slot.quantity.toString(),
                  backgroundColor: theme.quantitySquareBackground,
                  foregroundColor: theme.quantitySquareForeground,
                ),
              ],
            ),
            const SizedBox(height: 12),
            InfoSquare(
              expanded: false,
              icon: Icons.qr_code,
              label: l10n.productBarcodeLabel,
              value: slot.productBarcode,
              backgroundColor: theme.barcodeSquareBackground,
              foregroundColor: theme.barcodeSquareForeground,
            ),
            if (!slot.isClosed) ...[
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => _confirmCloseSlot(slot),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(l10n.closeSlot),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.undo, color: theme.colorScheme.primary, size: 32),
                  tooltip: l10n.undoProduct,
                  onPressed: slot.quantity > 1 ? () => _confirmUndo(slot) : null,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: theme.destructiveColor, size: 32),
                  tooltip: l10n.deleteProduct,
                  onPressed: () => _confirmDelete(slot),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
