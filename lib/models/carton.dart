import 'slot.dart';

enum CartonStatus { active, finished }

class Carton {
  const Carton({
    required this.id,
    required this.ibrBarcode,
    required this.status,
    required this.createdAt,
    required this.finishedAt,
    required this.nextSlot,
    required this.slots,
  });

  final String id;
  final String ibrBarcode;
  final CartonStatus status;
  final DateTime createdAt;
  final DateTime? finishedAt;
  final int nextSlot;
  final List<Slot> slots;

  bool get isActive => status == CartonStatus.active;

  int get totalQuantity {
    return slots.fold<int>(0, (sum, slot) => sum + slot.quantity);
  }

  Carton copyWith({
    String? id,
    String? ibrBarcode,
    CartonStatus? status,
    DateTime? createdAt,
    DateTime? finishedAt,
    int? nextSlot,
    List<Slot>? slots,
  }) {
    return Carton(
      id: id ?? this.id,
      ibrBarcode: ibrBarcode ?? this.ibrBarcode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt ?? this.finishedAt,
      nextSlot: nextSlot ?? this.nextSlot,
      slots: slots ?? this.slots,
    );
  }

  factory Carton.fromJson(Map<String, dynamic> json) {
    final statusRaw = json['status'] as String? ?? 'active';
    return Carton(
      id: json['id'] as String,
      ibrBarcode: json['ibrBarcode'] as String,
      status: statusRaw == 'finished' ? CartonStatus.finished : CartonStatus.active,
      createdAt: DateTime.parse(json['createdAt'] as String),
      finishedAt: json['finishedAt'] != null
          ? DateTime.parse(json['finishedAt'] as String)
          : null,
      nextSlot: json['nextSlot'] as int? ?? 1,
      slots: (json['slots'] as List<dynamic>? ?? [])
          .map((e) => Slot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ibrBarcode': ibrBarcode,
      'status': status == CartonStatus.finished ? 'finished' : 'active',
      'createdAt': createdAt.toUtc().toIso8601String(),
      'finishedAt': finishedAt?.toUtc().toIso8601String(),
      'nextSlot': nextSlot,
      'slots': slots.map((s) => s.toJson()).toList(),
    };
  }
}
