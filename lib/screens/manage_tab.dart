import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/carton.dart';
import '../services/print_service.dart';
import '../services/sort_storage_service.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import '../widgets/carton_print_helper.dart';
import 'carton_slots_screen.dart';

class ManageTab extends StatefulWidget {
  const ManageTab({
    super.key,
    required this.storage,
    required this.soundService,
    required this.printService,
    required this.cartons,
    required this.onDataChanged,
  });

  final SortStorageService storage;
  final SoundService soundService;
  final PrintService printService;
  final List<Carton> cartons;
  final VoidCallback onDataChanged;

  @override
  State<ManageTab> createState() => _ManageTabState();
}

class _ManageTabState extends State<ManageTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Carton> _filteredCartons() {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return widget.cartons;
    }
    return widget.cartons
        .where((carton) => carton.ibrBarcode.toLowerCase().contains(query))
        .toList();
  }

  bool get _hasActiveCarton => widget.storage.getActiveCarton() != null;

  Future<void> _confirmFinishSorting(Carton carton) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.finishSortingTitle),
        content: Text(l10n.finishSortingContent(carton.ibrBarcode)),
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
      final cartonId = carton.id;
      await widget.storage.finishActiveCarton();
      await widget.soundService.play(SoundEvent.sortingFinished);
      widget.onDataChanged();

      final printResult = await widget.printService.printCartonLabels(
        cartonId: cartonId,
        l10n: l10n,
      );
      if (mounted && printResult.reason != PrintFailureReason.noPrinter) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              printResult.success
                  ? l10n.printSuccess(printResult.labelCount)
                  : '${printResultMessage(printResult, l10n)}\n${l10n.printFailedRetryHint}',
            ),
          ),
        );
      }
    }
  }

  Future<void> _printCartonLabels(Carton carton) async {
    final result = await runCartonPrint(context, widget.printService, carton.id);
    if (!mounted) {
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(printResultMessage(result, l10n)),
      ),
    );
  }

  Future<void> _confirmReopen(Carton carton) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.reopenCartonTitle),
        content: Text(l10n.reopenCartonContent(carton.ibrBarcode)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.reopenCarton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.storage.reopenCarton(carton.id);
      widget.onDataChanged();
    }
  }

  Future<void> _confirmDelete(Carton carton) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteCartonTitle),
        content: Text(l10n.deleteCartonContent(carton.ibrBarcode)),
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
      await widget.storage.deleteCarton(carton.id);
      widget.onDataChanged();
    }
  }

  Future<void> _confirmClearAll() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearAllHistoryTitle),
        content: Text(l10n.clearAllHistoryContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.clearAll),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.storage.clearAll();
      widget.onDataChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final filtered = _filteredCartons();
    final emptyTextStyle = TextStyle(fontSize: 18, color: theme.mutedText);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchCartons,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      tooltip: l10n.clearSearch,
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    ),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        Expanded(
          child: widget.cartons.isEmpty
              ? Center(child: Text(l10n.noCartonsYet, style: emptyTextStyle))
              : filtered.isEmpty
                  ? Center(child: Text(l10n.noSearchResults, style: emptyTextStyle))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final carton = filtered[index];
                        return _CartonTile(
                          key: ValueKey(carton.id),
                          carton: carton,
                          totalQuantity: widget.storage.getTotalQuantityForCarton(carton.id),
                          hasSlots: widget.storage.getSlotsForCarton(carton.id).isNotEmpty,
                          canReopen: !_hasActiveCarton,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => CartonSlotsScreen(
                                  storage: widget.storage,
                                  soundService: widget.soundService,
                                  cartonId: carton.id,
                                  onDataChanged: widget.onDataChanged,
                                ),
                              ),
                            );
                          },
                          onFinish: carton.isActive
                              ? () => _confirmFinishSorting(carton)
                              : null,
                          onReopen: () => _confirmReopen(carton),
                          onDelete: () => _confirmDelete(carton),
                          onPrint: () => _printCartonLabels(carton),
                        );
                      },
                    ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: widget.cartons.isEmpty ? null : _confirmClearAll,
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.destructiveColor,
                  side: BorderSide(color: theme.destructiveBorder),
                ),
                icon: const Icon(Icons.delete_sweep, size: 24),
                label: Text(l10n.clearAll, style: const TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CartonTile extends StatelessWidget {
  const _CartonTile({
    super.key,
    required this.carton,
    required this.totalQuantity,
    required this.hasSlots,
    required this.canReopen,
    required this.onTap,
    required this.onReopen,
    required this.onDelete,
    required this.onPrint,
    this.onFinish,
  });

  final Carton carton;
  final int totalQuantity;
  final bool hasSlots;
  final bool canReopen;
  final VoidCallback onTap;
  final VoidCallback? onFinish;
  final VoidCallback onReopen;
  final VoidCallback onDelete;
  final VoidCallback onPrint;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            title: Text(
              carton.ibrBarcode,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carton.isActive ? l10n.activeCarton : l10n.finishedCarton,
                  style: TextStyle(
                    color: carton.isActive ? theme.successText : theme.mutedText,
                  ),
                ),
                if (!carton.isActive) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 18,
                        color: theme.quantitySquareForeground,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l10n.cartonTotalQuantity(totalQuantity),
                        style: TextStyle(
                          fontSize: 15,
                          color: theme.mutedText,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'print':
                    onPrint();
                  case 'reopen':
                    onReopen();
                  case 'delete':
                    onDelete();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'print',
                  enabled: hasSlots,
                  child: Text(
                    l10n.printLabels,
                    style: TextStyle(
                      color: hasSlots
                          ? theme.colorScheme.primary
                          : theme.disabledColor,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'reopen',
                  enabled: !carton.isActive && canReopen,
                  child: Text(
                    l10n.reopenCarton,
                    style: TextStyle(
                      color: (!carton.isActive && canReopen)
                          ? theme.colorScheme.primary
                          : theme.disabledColor,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    l10n.deleteCarton,
                    style: TextStyle(color: theme.destructiveColor),
                  ),
                ),
              ],
            ),
            onTap: onTap,
          ),
          if (onFinish != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton(
                  onPressed: onFinish,
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.successText,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(l10n.finishSorting),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
