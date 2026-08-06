class Slot {
  const Slot({
    required this.id,
    required this.slot,
    required this.productBarcode,
    required this.quantity,
    required this.isClosed,
    required this.createdAt,
  });

  final String id;
  final String slot;
  final String productBarcode;
  final int quantity;
  final bool isClosed;
  final DateTime createdAt;

  Slot copyWith({
    String? id,
    String? slot,
    String? productBarcode,
    int? quantity,
    bool? isClosed,
    DateTime? createdAt,
  }) {
    return Slot(
      id: id ?? this.id,
      slot: slot ?? this.slot,
      productBarcode: productBarcode ?? this.productBarcode,
      quantity: quantity ?? this.quantity,
      isClosed: isClosed ?? this.isClosed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'] as String,
      slot: json['slot'] as String,
      productBarcode: json['productBarcode'] as String,
      quantity: json['quantity'] as int? ?? 1,
      isClosed: json['isClosed'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slot': slot,
      'productBarcode': productBarcode,
      'quantity': quantity,
      'isClosed': isClosed,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
