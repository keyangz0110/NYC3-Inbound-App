import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../l10n/app_localizations.dart';
import '../services/print_service.dart';
import '../services/sort_storage_service.dart';
import '../services/sound_service.dart';
import '../widgets/carton_print_helper.dart';
import '../theme/app_theme.dart';
import '../widgets/info_square.dart';

class SortTab extends StatefulWidget {
  const SortTab({
    super.key,
    required this.storage,
    required this.soundService,
    required this.printService,
    required this.onDataChanged,
    required this.tabController,
    required this.toastContext,
    this.tabBarFolded = false,
    this.displayQuantityOnSortScreen = true,
  });

  final SortStorageService storage;
  final SoundService soundService;
  final PrintService printService;
  final VoidCallback onDataChanged;
  final TabController tabController;
  final BuildContext toastContext;
  final bool tabBarFolded;
  final bool displayQuantityOnSortScreen;

  static const int tabIndex = 0;
  static const Duration scanCooldown = Duration(milliseconds: 500);

  @override
  State<SortTab> createState() => _SortTabState();
}

class _SortTabState extends State<SortTab> {
  final TextEditingController _scanController = TextEditingController();
  final FocusNode _scanFocus = FocusNode();

  String? _currentSlot;
  int? _currentQuantity;
  String? _lastSlotId;
  bool _isActive = true;
  bool _scanInProgress = false;
  DateTime? _lastScanAcceptedAt;
  FToast? _fToast;

  bool get _shouldAcceptScans {
    return widget.tabController.index == SortTab.tabIndex &&
        widget.tabController.offset == 0.0;
  }

  bool get _hasActiveCarton => widget.storage.getActiveCarton() != null;

  void _ensureFToast() {
    _fToast = FToast();
    _fToast!.init(widget.toastContext);
  }

  @override
  void initState() {
    super.initState();
    _isActive = _shouldAcceptScans;
    widget.tabController.addListener(_onTabChanged);
    _syncFromStorage();
    if (_isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _shouldAcceptScans) {
          _ensureFToast();
          _scanFocus.requestFocus();
        }
      });
    }
  }

  void _syncFromStorage() {
    if (!_hasActiveCarton) {
      _currentSlot = null;
      _currentQuantity = null;
      _lastSlotId = null;
    }
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabChanged);
    _scanController.dispose();
    _scanFocus.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    final isActive = _shouldAcceptScans;
    if (isActive == _isActive) {
      return;
    }

    setState(() {
      _isActive = isActive;
      _syncFromStorage();
    });

    if (isActive) {
      _ensureFToast();
      _scanFocus.requestFocus();
    } else {
      _fToast?.removeQueuedCustomToasts();
      _scanFocus.unfocus();
      _scanController.clear();
    }
  }

  void _showToast(
    String message, {
    required bool isExisting,
    bool isError = false,
  }) {
    _ensureFToast();
    final theme = Theme.of(context);
    final backgroundColor = isError
        ? theme.destructiveColor
        : (isExisting ? theme.warningText : theme.successText);

    _fToast?.removeQueuedCustomToasts();
    _fToast?.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }

  Future<void> _handleScan(String value) async {
    if (!_isActive || _scanInProgress) {
      return;
    }

    final barcode = value.trim();
    if (barcode.isEmpty) {
      return;
    }

    final now = DateTime.now();
    final lastScan = _lastScanAcceptedAt;
    if (lastScan != null &&
        now.difference(lastScan) < SortTab.scanCooldown) {
      _scanController.clear();
      if (_isActive && mounted) {
        _scanFocus.requestFocus();
      }
      return;
    }

    _scanInProgress = true;
    _lastScanAcceptedAt = now;
    final l10n = AppLocalizations.of(context)!;

    try {
      if (!_hasActiveCarton) {
        await widget.storage.openCarton(barcode);
        widget.onDataChanged();
        if (!mounted || !_isActive) {
          return;
        }
        await widget.soundService.play(SoundEvent.cartonOpened);
        setState(() {
          _currentSlot = null;
          _currentQuantity = null;
          _lastSlotId = null;
        });
        _showToast(l10n.cartonOpened, isExisting: false);
      } else {
        final result = await widget.storage.scanProduct(barcode);
        widget.onDataChanged();
        if (!mounted || !_isActive) {
          return;
        }
        await widget.soundService.play(SoundEvent.productScanned);
        setState(() {
          _currentSlot = result.slot;
          _currentQuantity = result.quantity;
          _lastSlotId = result.slotId;
        });
        _showToast(
          result.isNewSlot ? l10n.newSlotAssigned : l10n.existingSlot,
          isExisting: !result.isNewSlot,
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      final message = e is ArgumentError && e.message == 'Barcode must start with IBR'
          ? l10n.invalidIbrBarcode
          : e is StateError && e.message == 'An active carton already exists'
              ? l10n.activeCartonExists
              : l10n.errorMessage(e.toString());
      _showToast(message, isExisting: false, isError: true);
    } finally {
      _scanInProgress = false;
      _scanController.clear();
      if (_isActive && mounted) {
        _scanFocus.requestFocus();
      }
    }
  }

  Future<void> _onQuantitySquareTapped() async {
    final l10n = AppLocalizations.of(context)!;
    final active = widget.storage.getActiveCarton();
    final slotId = _lastSlotId;
    final slotNumber = _currentSlot;
    final quantity = _currentQuantity;

    if (active == null ||
        slotId == null ||
        slotNumber == null ||
        quantity == null ||
        quantity < 1) {
      return;
    }

    if (quantity > 1) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.undoProductTitle),
          content: Text(l10n.undoProductContent(slotNumber)),
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

      if (confirmed != true) {
        return;
      }

      try {
        await widget.storage.undoProductScan(active.id, slotId);
        widget.onDataChanged();
        if (!mounted) {
          return;
        }
        setState(() {
          _currentQuantity = quantity - 1;
        });
        if (_isActive) {
          _scanFocus.requestFocus();
        }
      } catch (e) {
        if (!mounted) {
          return;
        }
        _showToast(l10n.errorMessage(e.toString()), isExisting: false, isError: true);
      }
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteProductTitle),
        content: Text(l10n.deleteProductContent(slotNumber)),
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

    if (confirmed != true) {
      return;
    }

    try {
      await widget.storage.deleteProduct(active.id, slotId);
      widget.onDataChanged();
      if (!mounted) {
        return;
      }
      setState(() {
        _currentSlot = null;
        _currentQuantity = null;
        _lastSlotId = null;
      });
      if (_isActive) {
        _scanFocus.requestFocus();
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      _showToast(l10n.errorMessage(e.toString()), isExisting: false, isError: true);
    }
  }

  Future<void> _confirmCloseSlot() async {
    final l10n = AppLocalizations.of(context)!;
    final active = widget.storage.getActiveCarton();
    if (active == null || _lastSlotId == null || _currentSlot == null) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.closeSlotTitle),
        content: Text(l10n.closeSlotContent(_currentSlot!)),
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
      await widget.storage.closeSlot(active.id, _lastSlotId!);
      await widget.soundService.play(SoundEvent.slotClosed);
      widget.onDataChanged();
      if (mounted) {
        setState(() {
          _lastSlotId = null;
        });
      }
    }
  }

  Future<void> _confirmFinishSorting() async {
    final l10n = AppLocalizations.of(context)!;
    final active = widget.storage.getActiveCarton();
    if (active == null) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.finishSortingTitle),
        content: Text(l10n.finishSortingContent(active.ibrBarcode)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.finishSorting),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final cartonId = active.id;
      await widget.storage.finishActiveCarton();
      await widget.soundService.play(SoundEvent.sortingFinished);
      widget.onDataChanged();
      if (mounted) {
        setState(() {
          _currentSlot = null;
          _currentQuantity = null;
          _lastSlotId = null;
        });
      }

      final printResult = await widget.printService.printCartonLabels(
        cartonId: cartonId,
        l10n: l10n,
      );
      if (mounted && printResult.reason != PrintFailureReason.noPrinter) {
        final message = printResult.success
            ? l10n.printSuccess(printResult.labelCount)
            : '${printResultMessage(printResult, l10n)}\n${l10n.printFailedRetryHint}';
        _showToast(
          message,
          isExisting: false,
          isError: !printResult.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final activeCarton = widget.storage.getActiveCarton();
    final hasActiveCarton = activeCarton != null;
    final canCloseSlot = hasActiveCarton && _lastSlotId != null;
    final compactChrome = widget.tabBarFolded && hasActiveCarton;
    final showQuantity = widget.displayQuantityOnSortScreen;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        compactChrome ? 8 : 16,
        compactChrome ? 8 : 16,
        compactChrome ? 8 : 16,
        compactChrome ? 8 : 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!compactChrome) ...[
            Text(
              hasActiveCarton ? l10n.scanProductBarcode : l10n.scanBoxCartonBarcode,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (hasActiveCarton) ...[
              const SizedBox(height: 4),
              Text(
                activeCarton.ibrBarcode,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.mutedText),
              ),
            ],
            const SizedBox(height: 12),
          ],
          TextField(
            controller: _scanController,
            focusNode: _scanFocus,
            autofocus: _isActive,
            enabled: _isActive,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: l10n.readyToScan,
              isDense: compactChrome,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: compactChrome ? 8 : 14,
              ),
            ),
            style: compactChrome ? theme.textTheme.bodyLarge : theme.textTheme.titleMedium,
            textInputAction: TextInputAction.done,
            onSubmitted: _handleScan,
          ),
          if (hasActiveCarton) ...[
            SizedBox(height: compactChrome ? 8 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: InfoSquare(
                      icon: Icons.grid_view,
                      label: l10n.slotLabel,
                      value: _currentSlot ?? '—',
                      backgroundColor: theme.slotSquareBackground,
                      foregroundColor: theme.slotSquareForeground,
                      maximize: true,
                    ),
                  ),
                  if (showQuantity) ...[
                    SizedBox(height: compactChrome ? 8 : 12),
                    Expanded(
                      child: InfoSquare(
                        icon: Icons.inventory_2_outlined,
                        label: l10n.quantityLabel,
                        value: _currentQuantity?.toString() ?? '—',
                        backgroundColor: theme.quantitySquareBackground,
                        foregroundColor: theme.quantitySquareForeground,
                        maximize: true,
                        onTap: (_currentQuantity != null &&
                                _currentQuantity! >= 1 &&
                                _lastSlotId != null)
                            ? _onQuantitySquareTapped
                            : null,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: compactChrome ? 8 : 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: canCloseSlot ? _confirmCloseSlot : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      minimumSize: Size.fromHeight(compactChrome ? 40 : 48),
                    ),
                    child: Text(l10n.closeSlot),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _confirmFinishSorting,
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.successText,
                      foregroundColor: Colors.white,
                      minimumSize: Size.fromHeight(compactChrome ? 40 : 48),
                    ),
                    child: Text(l10n.finishSorting),
                  ),
                ),
              ],
            ),
          ] else
            const Spacer(),
        ],
      ),
    );
  }
}
