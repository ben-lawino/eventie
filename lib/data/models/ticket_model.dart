class TicketModel {
  final String id;
  final String type; // dynamic
  final double price;
  final int quantity;
  final int sold;

  TicketModel({
    required this.id,
    required this.type,
    required this.price,
    required this.quantity,
    this.sold = 0,
  });

  bool get isSoldOut => sold >= quantity;

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      type: json['type'],
      price: json['price'],
      quantity: json['quantity'],
      sold: json['sold'] ?? 0, id: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'price': price,
      'quantity': quantity,
      'sold': sold,
    };
  }
}
