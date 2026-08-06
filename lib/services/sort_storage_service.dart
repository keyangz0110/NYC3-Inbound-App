import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

import '../models/carton.dart';
import '../models/slot.dart';

class ScanProductResult {
  const ScanProductResult({
    required this.slot,
    required this.quantity,
    required this.isNewSlot,
    required this.slotId,
  });

  final String slot;
  final int quantity;
  final bool isNewSlot;
  final String slotId;
}

class SortStorageService {
  SortStorageService();

  static const String _liveFileName = 'sorting_data.json';
  static const String _historyFileName = 'sort_history.json';

  String? _activeCartonId;
  final List<Carton> _cartons = [];
  bool _loaded = false;
  bool _legacyRenamed = false;
  Future<void> _mutationLock = Future<void>.value();

  Future<T> _serialized<T>(Future<T> Function() action) {
    final operation = _mutationLock.then((_) => action());
    _mutationLock = operation.then((_) {}, onError: (_) {});
    return operation;
  }

  Future<void> load() async {
    await _ensureLoaded();
    _consolidateStorage();
    await _persistLive();
  }

  List<Carton> get cartons => List.unmodifiable(_cartons);

  Carton? getActiveCarton() {
    if (_activeCartonId == null) {
      return null;
    }
    for (final carton in _cartons) {
      if (carton.id == _activeCartonId) {
        return carton;
      }
    }
    return null;
  }

  List<Carton> getCartons() {
    final active = <Carton>[];
    final finished = <Carton>[];

    for (final carton in _cartons) {
      if (carton.isActive) {
        active.add(carton);
      } else {
        finished.add(carton);
      }
    }

    finished.sort((a, b) {
      final aTime = a.finishedAt ?? a.createdAt;
      final bTime = b.finishedAt ?? b.createdAt;
      return bTime.compareTo(aTime);
    });

    return [...active, ...finished];
  }

  List<Slot> getSlotsForCarton(String cartonId) {
    final carton = getCartonById(cartonId);
    if (carton == null) {
      return const [];
    }
    return _dedupeSlots(carton.slots);
  }

  int getTotalQuantityForCarton(String cartonId) {
    return getSlotsForCarton(cartonId)
        .fold<int>(0, (sum, slot) => sum + slot.quantity);
  }

  Carton? getCartonById(String cartonId) {
    for (final carton in _cartons) {
      if (carton.id == cartonId) {
        return carton;
      }
    }
    return null;
  }

  static String formatSlot(int value) {
    return value.toString().padLeft(2, '0');
  }

  static int parseSlotNumber(String slot) {
    return int.parse(slot);
  }

  static bool isValidIbrBarcode(String barcode) {
    return barcode.startsWith('IBR');
  }

  String _newId() {
    final random = Random();
    return '${DateTime.now().microsecondsSinceEpoch}_${random.nextInt(0xFFFFFF).toRadixString(16)}';
  }

  Future<void> _ensureLoaded() async {
    if (_loaded) {
      return;
    }

    await _maybeRenameLegacyHistory();
    final file = await _getLiveFile();
    if (!await file.exists()) {
      _loaded = true;
      return;
    }

    final contents = await file.readAsString();
    if (contents.trim().isEmpty) {
      _loaded = true;
      return;
    }

    final data = jsonDecode(contents) as Map<String, dynamic>;
    _activeCartonId = data['activeCartonId'] as String?;
    final rawCartons = data['cartons'] as List<dynamic>? ?? [];
    _cartons
      ..clear()
      ..addAll(rawCartons.map((e) => Carton.fromJson(e as Map<String, dynamic>)));
    _loaded = true;
  }

  Future<void> _maybeRenameLegacyHistory() async {
    if (_legacyRenamed) {
      return;
    }
    _legacyRenamed = true;

    final directory = await getApplicationDocumentsDirectory();
    final legacyFile = File('${directory.path}/$_historyFileName');
    if (!await legacyFile.exists()) {
      return;
    }

    final contents = await legacyFile.readAsString();
    if (contents.trim().isEmpty) {
      return;
    }

    try {
      final data = jsonDecode(contents) as Map<String, dynamic>;
      if (data.containsKey('entries') && !data.containsKey('clearedSessions')) {
        final backup = File('${directory.path}/$_historyFileName.bak');
        if (!await backup.exists()) {
          await legacyFile.rename(backup.path);
        }
      }
    } catch (_) {
      // Ignore malformed legacy files.
    }
  }

  Future<File> _getLiveFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_liveFileName');
  }

  Future<File> _getHistoryFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_historyFileName');
  }

  Future<void> _persistLive() async {
    final file = await _getLiveFile();
    final data = {
      'activeCartonId': _activeCartonId,
      'cartons': _cartons.map((c) => c.toJson()).toList(),
    };
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(data));
  }

  int _allocateSlotNumber(Carton carton) {
    final used = <int>{
      for (final slot in carton.slots) parseSlotNumber(slot.slot),
    };

    for (var i = 1; i < carton.nextSlot; i++) {
      if (!used.contains(i)) {
        return i;
      }
    }

    final number = carton.nextSlot;
    return number;
  }

  int _cartonIndex(String cartonId) {
    return _cartons.indexWhere((c) => c.id == cartonId);
  }

  Carton _updateCarton(int index, Carton carton) {
    if (index < 0 || index >= _cartons.length) {
      throw StateError('Carton not found');
    }
    _cartons[index] = carton;
    return carton;
  }

  Carton? _findCartonByIbr(String ibrBarcode) {
    for (final carton in _cartons) {
      if (carton.ibrBarcode == ibrBarcode) {
        return carton;
      }
    }
    return null;
  }

  List<Slot> _dedupeSlots(List<Slot> slots) {
    final byNumber = <String, Slot>{};
    for (final slot in slots) {
      final existing = byNumber[slot.slot];
      if (existing == null || slot.createdAt.isAfter(existing.createdAt)) {
        byNumber[slot.slot] = slot;
      }
    }

    final deduped = byNumber.values.toList()
      ..sort(
        (a, b) => parseSlotNumber(a.slot).compareTo(parseSlotNumber(b.slot)),
      );
    return deduped;
  }

  Carton _mergeCartons(Carton primary, Carton secondary) {
    final mergedSlots = _dedupeSlots([...primary.slots, ...secondary.slots]);
    final isActive = primary.isActive || secondary.isActive;
    final finishedAt = isActive
        ? null
        : _latestDateTime(primary.finishedAt, secondary.finishedAt);
    final createdAt = primary.createdAt.isBefore(secondary.createdAt)
        ? primary.createdAt
        : secondary.createdAt;

    return primary.copyWith(
      status: isActive ? CartonStatus.active : CartonStatus.finished,
      createdAt: createdAt,
      finishedAt: finishedAt,
      nextSlot: primary.nextSlot > secondary.nextSlot ? primary.nextSlot : secondary.nextSlot,
      slots: mergedSlots,
    );
  }

  DateTime? _latestDateTime(DateTime? a, DateTime? b) {
    if (a == null) {
      return b;
    }
    if (b == null) {
      return a;
    }
    return a.isAfter(b) ? a : b;
  }

  void _consolidateStorage() {
    if (_cartons.isEmpty) {
      return;
    }

    final mergedByIbr = <String, Carton>{};
    final mergeOrder = <String>[];

    for (final carton in _cartons) {
      final existing = mergedByIbr[carton.ibrBarcode];
      if (existing == null) {
        mergedByIbr[carton.ibrBarcode] = carton.copyWith(
          slots: _dedupeSlots(carton.slots),
        );
        mergeOrder.add(carton.ibrBarcode);
      } else {
        mergedByIbr[carton.ibrBarcode] = _mergeCartons(existing, carton);
      }
    }

    final consolidated = mergeOrder.map((ibr) => mergedByIbr[ibr]!).toList();
    _cartons
      ..clear()
      ..addAll(consolidated);

    if (_activeCartonId != null &&
        !_cartons.any((carton) => carton.id == _activeCartonId)) {
      final activeCarton = _cartons.where((carton) => carton.isActive);
      _activeCartonId = activeCarton.isEmpty ? null : activeCarton.first.id;
    }

    if (_activeCartonId == null) {
      final activeCarton = _cartons.where((carton) => carton.isActive);
      if (activeCarton.length == 1) {
        _activeCartonId = activeCarton.first.id;
      }
    }
  }

  Slot? _findLatestOpenSlotForBarcode(Carton carton, String barcode) {
    Slot? latest;
    for (final slot in carton.slots) {
      if (!slot.isClosed && slot.productBarcode == barcode) {
        latest = slot;
      }
    }
    return latest;
  }

  Future<Carton> openCarton(String ibrBarcode) async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      final trimmed = ibrBarcode.trim();
      if (trimmed.isEmpty) {
        throw ArgumentError('IBR barcode cannot be empty');
      }
      if (!isValidIbrBarcode(trimmed)) {
        throw ArgumentError('Barcode must start with IBR');
      }

      final active = getActiveCarton();
      final existing = _findCartonByIbr(trimmed);

      if (existing != null) {
        if (active != null && active.id != existing.id) {
          throw StateError('An active carton already exists');
        }

        final index = _cartonIndex(existing.id);
        final resumed = existing.copyWith(
          status: CartonStatus.active,
          finishedAt: null,
          slots: _dedupeSlots(existing.slots),
        );
        _updateCarton(index, resumed);
        _activeCartonId = existing.id;
        await _persistLive();
        return resumed;
      }

      if (active != null) {
        throw StateError('An active carton already exists');
      }

      final carton = Carton(
        id: _newId(),
        ibrBarcode: trimmed,
        status: CartonStatus.active,
        createdAt: DateTime.now(),
        finishedAt: null,
        nextSlot: 1,
        slots: const [],
      );
      _cartons.add(carton);
      _activeCartonId = carton.id;
      await _persistLive();
      return carton;
    });
  }

  Future<ScanProductResult> scanProduct(String barcode) async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      final trimmed = barcode.trim();
      if (trimmed.isEmpty) {
        throw ArgumentError('Product barcode cannot be empty');
      }

      final active = getActiveCarton();
      if (active == null) {
        throw StateError('No active carton');
      }

      final cartonIndex = _cartonIndex(active.id);
      if (cartonIndex == -1) {
        throw StateError('Active carton not found');
      }

      var carton = _cartons[cartonIndex];
      final existingSlot = _findLatestOpenSlotForBarcode(carton, trimmed);

      if (existingSlot != null) {
        final slotIndex = carton.slots.indexWhere((s) => s.id == existingSlot.id);
        if (slotIndex == -1) {
          throw StateError('Slot not found');
        }
        final updatedSlot = existingSlot.copyWith(quantity: existingSlot.quantity + 1);
        final updatedSlots = List<Slot>.from(carton.slots)..[slotIndex] = updatedSlot;
        carton = _updateCarton(cartonIndex, carton.copyWith(slots: updatedSlots));
        await _persistLive();
        return ScanProductResult(
          slot: updatedSlot.slot,
          quantity: updatedSlot.quantity,
          isNewSlot: false,
          slotId: updatedSlot.id,
        );
      }

      final slotNumber = _allocateSlotNumber(carton);
      final formattedSlot = formatSlot(slotNumber);
      final newSlot = Slot(
        id: _newId(),
        slot: formattedSlot,
        productBarcode: trimmed,
        quantity: 1,
        isClosed: false,
        createdAt: DateTime.now(),
      );
      final updatedSlots = [...carton.slots, newSlot];
      final newNextSlot = slotNumber >= carton.nextSlot ? slotNumber + 1 : carton.nextSlot;
      carton = _updateCarton(
        cartonIndex,
        carton.copyWith(slots: updatedSlots, nextSlot: newNextSlot),
      );
      await _persistLive();
      return ScanProductResult(
        slot: formattedSlot,
        quantity: 1,
        isNewSlot: true,
        slotId: newSlot.id,
      );
    });
  }

  Future<void> closeSlot(String cartonId, String slotId) async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      final cartonIndex = _cartonIndex(cartonId);
      if (cartonIndex == -1) {
        throw StateError('Carton not found');
      }

      final carton = _cartons[cartonIndex];
      final slotIndex = carton.slots.indexWhere((s) => s.id == slotId);
      if (slotIndex == -1) {
        throw StateError('Slot not found');
      }

      final slot = carton.slots[slotIndex];
      if (slot.isClosed) {
        return;
      }

      final updatedSlots = List<Slot>.from(carton.slots)
        ..[slotIndex] = slot.copyWith(isClosed: true);
      _updateCarton(cartonIndex, carton.copyWith(slots: updatedSlots));
      await _persistLive();
    });
  }

  Future<void> finishActiveCarton() async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      final active = getActiveCarton();
      if (active == null) {
        throw StateError('No active carton');
      }

      final cartonIndex = _cartonIndex(active.id);
      if (cartonIndex == -1) {
        throw StateError('Active carton not found');
      }

      _updateCarton(
        cartonIndex,
        active.copyWith(
          status: CartonStatus.finished,
          finishedAt: DateTime.now(),
          slots: _dedupeSlots(active.slots),
        ),
      );
      _activeCartonId = null;
      await _persistLive();
    });
  }

  Future<void> reopenCarton(String cartonId) async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      if (getActiveCarton() != null) {
        throw StateError('An active carton already exists');
      }

      final cartonIndex = _cartonIndex(cartonId);
      if (cartonIndex == -1) {
        throw StateError('Carton not found');
      }

      final carton = _cartons[cartonIndex];
      if (carton.isActive) {
        return;
      }

      _updateCarton(
        cartonIndex,
        carton.copyWith(
          status: CartonStatus.active,
          finishedAt: null,
          slots: _dedupeSlots(carton.slots),
        ),
      );
      _activeCartonId = carton.id;
      await _persistLive();
    });
  }

  Future<void> deleteCarton(String cartonId) async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      final cartonIndex = _cartonIndex(cartonId);
      if (cartonIndex == -1) {
        return;
      }

      if (_activeCartonId == cartonId) {
        _activeCartonId = null;
      }
      _cartons.removeAt(cartonIndex);
      await _persistLive();
    });
  }

  Future<void> undoProductScan(String cartonId, String slotId) async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      final cartonIndex = _cartonIndex(cartonId);
      if (cartonIndex == -1) {
        throw StateError('Carton not found');
      }

      final carton = _cartons[cartonIndex];
      final slotIndex = carton.slots.indexWhere((s) => s.id == slotId);
      if (slotIndex == -1) {
        throw StateError('Slot not found');
      }

      final slot = carton.slots[slotIndex];
      if (slot.quantity <= 1) {
        throw StateError('Cannot undo when quantity is 1');
      }

      final updatedSlots = List<Slot>.from(carton.slots)
        ..[slotIndex] = slot.copyWith(quantity: slot.quantity - 1);
      _updateCarton(cartonIndex, carton.copyWith(slots: updatedSlots));
      await _persistLive();
    });
  }

  Future<void> deleteProduct(String cartonId, String slotId) async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      final cartonIndex = _cartonIndex(cartonId);
      if (cartonIndex == -1) {
        throw StateError('Carton not found');
      }

      final carton = _cartons[cartonIndex];
      final updatedSlots = carton.slots.where((s) => s.id != slotId).toList();
      _updateCarton(cartonIndex, carton.copyWith(slots: updatedSlots));
      await _persistLive();
    });
  }

  Future<void> clearAll() async {
    return _serialized(() async {
      await _ensureLoaded();
      _consolidateStorage();

      if (_cartons.isNotEmpty) {
        final historyFile = await _getHistoryFile();
        Map<String, dynamic> historyData = {'clearedSessions': <dynamic>[]};

        if (await historyFile.exists()) {
          final contents = await historyFile.readAsString();
          if (contents.trim().isNotEmpty) {
            historyData = jsonDecode(contents) as Map<String, dynamic>;
          }
        }

        final sessions = List<Map<String, dynamic>>.from(
          historyData['clearedSessions'] as List<dynamic>? ?? [],
        );
        sessions.add({
          'clearedAt': DateTime.now().toUtc().toIso8601String(),
          'cartons': _cartons.map((c) => c.toJson()).toList(),
        });
        historyData['clearedSessions'] = sessions;
        await historyFile.writeAsString(
          const JsonEncoder.withIndent('  ').convert(historyData),
        );
      }

      _cartons.clear();
      _activeCartonId = null;
      await _persistLive();
    });
  }

  Future<File> getHistoryFile() async {
    await _ensureLoaded();
    return _getHistoryFile();
  }

  Future<bool> hasHistoryData() async {
    final file = await getHistoryFile();
    if (!await file.exists()) {
      return false;
    }
    final contents = await file.readAsString();
    if (contents.trim().isEmpty) {
      return false;
    }
    try {
      final data = jsonDecode(contents) as Map<String, dynamic>;
      final sessions = data['clearedSessions'] as List<dynamic>? ?? [];
      return sessions.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
