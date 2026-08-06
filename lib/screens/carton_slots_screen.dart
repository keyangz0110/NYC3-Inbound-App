import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/carton.dart';
import '../models/slot.dart';
import '../services/sort_storage_service.dart';
import '../services/sound_service.dart';
import '../theme/app_theme.dart';
import 'slot_detail_screen.dart';

class CartonSlotsScreen extends StatefulWidget {
  const CartonSlotsScreen({
    super.key,
    required this.storage,
    required this.soundService,
    required this.cartonId,
    required this.onDataChanged,
  });

  final SortStorageService storage;
  final SoundService soundService;
  final String cartonId;
  final VoidCallback onDataChanged;

  @override
  State<CartonSlotsScreen> createState() => _CartonSlotsScreenState();
}

class _CartonSlotsScreenState extends State<CartonSlotsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Carton? get _carton => widget.storage.getCartonById(widget.cartonId);

  List<Slot> _filteredSlots(Carton carton) {
    final query = _searchQuery.trim().toLowerCase();
    final slots = widget.storage.getSlotsForCarton(carton.id);

    if (query.isEmpty) {
      return slots;
    }

    return slots.where((slot) {
      return slot.productBarcode.toLowerCase().contains(query) ||
          slot.slot.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final carton = _carton;

    if (carton == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.noCartonsYet)),
      );
    }

    final filtered = _filteredSlots(carton);
    final slots = widget.storage.getSlotsForCarton(carton.id);
    final totalQuantity = widget.storage.getTotalQuantityForCarton(carton.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(carton.ibrBarcode),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchSlots,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 22,
                  color: theme.quantitySquareForeground,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.cartonTotalQuantity(totalQuantity),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: slots.isEmpty
                ? Center(
                    child: Text(
                      l10n.noSearchResults,
                      style: TextStyle(fontSize: 18, color: theme.mutedText),
                    ),
                  )
                : filtered.isEmpty
                    ? Center(
                        child: Text(
                          l10n.noSearchResults,
                          style: TextStyle(fontSize: 18, color: theme.mutedText),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final slot = filtered[index];
                          return _SlotGridTile(
                            key: ValueKey(slot.id),
                            slot: slot,
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (context) => SlotDetailScreen(
                                    storage: widget.storage,
                                    soundService: widget.soundService,
                                    cartonId: carton.id,
                                    slotId: slot.id,
                                    onDataChanged: () {
                                      widget.onDataChanged();
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _SlotGridTile extends StatelessWidget {
  const _SlotGridTile({
    super.key,
    required this.slot,
    required this.onTap,
  });

  final Slot slot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isClosed = slot.isClosed;
    final backgroundColor =
        isClosed ? theme.closedSlotSquareBackground : theme.slotSquareBackground;
    final foregroundColor =
        isClosed ? theme.closedSlotSquareForeground : theme.slotSquareForeground;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isClosed
                  ? foregroundColor.withValues(alpha: 0.55)
                  : foregroundColor.withValues(alpha: 0.35),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                slot.slot,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: foregroundColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '×${slot.quantity}',
                style: TextStyle(
                  fontSize: 14,
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
