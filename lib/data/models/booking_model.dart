class BookingModel {
  final String id;
  final String userId;
  final String eventId;
  final String ticketId;
  final int quantity;
  final double totalPrice;
  final DateTime bookedAt;
  final String status;
  final String? paymentRef;
  final String fullName;
  final String email;
  final String phone;
  final String? cancellationReason;
  final DateTime? cancelledAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.ticketId,
    required this.quantity,
    required this.totalPrice,
    required this.bookedAt,
    required this.status,
    this.paymentRef,
    required this.fullName,
    required this.email,
    required this.phone,
    this.cancellationReason,
    this.cancelledAt,
  });

  // ✅ fromJson
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      userId: json['userId'],
      eventId: json['eventId'],
      ticketId: json['ticketId'],
      quantity: json['quantity'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      bookedAt: DateTime.parse(json['bookedAt']),
      status: json['status'] ?? 'pending',
      paymentRef: json['paymentRef'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      cancellationReason: json['cancellationReason'],
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'])
          : null,
    );
  }

  // ✅ toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'ticketId': ticketId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'bookedAt': bookedAt.toIso8601String(),
      'status': status,
      'paymentRef': paymentRef,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'cancellationReason': cancellationReason,
      'cancelledAt': cancelledAt?.toIso8601String(),
    };
  }

  // copyWith
  BookingModel copyWith({
    String? status,
    String? cancellationReason,
    DateTime? cancelledAt,
  }) {
    return BookingModel(
      id: id,
      userId: userId,
      eventId: eventId,
      ticketId: ticketId,
      quantity: quantity,
      totalPrice: totalPrice,
      bookedAt: bookedAt,
      status: status ?? this.status,
      paymentRef: paymentRef,
      fullName: fullName,
      email: email,
      phone: phone,
      cancellationReason:
      cancellationReason ?? this.cancellationReason,
      cancelledAt: cancelledAt ?? this.cancelledAt,
    );
  }
}