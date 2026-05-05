import 'package:uuid/uuid.dart';

class TicketModel {
  final String id;
  final String name;       // renamed from 'type' to match CreateEventScreen
  final double price;
  final int quantity;
  final int sold;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;

  TicketModel({
    String? id,
    required this.name,
    required this.price,
    this.quantity = 0,     // optional — no quantity field on the create screen
    this.sold = 0,
    this.currency = 'KES',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Backward-compat alias so any existing code using .type still compiles
  String get type => name;

  int get remaining => quantity - sold;
  bool get isSoldOut => quantity > 0 && sold >= quantity;
  double get revenue => sold * price;

  TicketModel copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    int? sold,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TicketModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      sold: sold ?? this.sold,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String?,
      name: (json['name'] ?? json['type']) as String,  // accepts both keys
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] ?? 0,
      sold: json['sold'] ?? 0,
      currency: json['currency'] ?? 'KES',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'sold': sold,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}