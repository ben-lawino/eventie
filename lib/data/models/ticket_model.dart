
class TicketModel {
  final String id;
  final String eventId;
  final String type; // e.g., 'regular', 'vip', 'vvip'
  final double price;
  final int totalQuantity;
  final int soldQuantity;

  TicketModel({
    required this.id,
    required this.eventId,
    required this.type,
    required this.price,
    required this.totalQuantity,
    required this.soldQuantity,
  });

  // 🔹 Computed property
  int get remainingQuantity => totalQuantity - soldQuantity;

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'],
      eventId: json['eventId'],
      type: json['type'],
      price: (json['price'] as num).toDouble(),
      totalQuantity: json['totalQuantity'],
      soldQuantity: json['soldQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'type': type,
      'price': price,
      'totalQuantity': totalQuantity,
      'soldQuantity': soldQuantity,
    };
  }
}
