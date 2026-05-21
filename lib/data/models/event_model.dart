import 'package:eventie/data/models/ticket_model.dart';

enum EventStatus { pending, approved, rejected }

class EventModel {
  final String id;
  final String title;
  final String description;

  final DateTime eventDate; // includes date + time

  final String location;
  final String? imageUrl;

  final String category;
  final String organizerId;

  final List<TicketModel> tickets;

  final bool isFeatured;

  final EventStatus status; // pending, approved, rejected

  final DateTime createdAt;
  final DateTime updatedAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.location,
    this.imageUrl,
    required this.category,
    required this.organizerId,
    required this.tickets,
    this.isFeatured = false,
    this.status = EventStatus.pending,
    required this.createdAt,
    required this.updatedAt,
  });

 //Getters

  //Total tickets available for this event
  int get totalTickets {
    return tickets.fold(
      0,
          (sum, ticket) => sum + ticket.quantity,
    );
  }

  // Total tickets sold
  int get totalSoldTickets {
    return tickets.fold(
      0,
          (sum, ticket) => sum + ticket.sold,
    );
  }

  //Remaining tickets
  int get remainingTickets {
    return totalTickets - totalSoldTickets;
  }

  // Whether the whole event is sold out
  bool get isSoldOut {
    return remainingTickets <= 0;
  }

  //Whether the event date has passed
  bool get isCompleted {
    return eventDate.isBefore(DateTime.now());
  }

  // Revenue generated from ticket sales
  double get revenue {
    return tickets.fold(
      0,
          (sum, ticket) => sum + (ticket.price * ticket.sold),
    );
  }

  // Whether the event is upcoming
  bool get isUpcoming {
    return eventDate.isAfter(DateTime.now());
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      eventDate: DateTime.parse(json['eventDate']),
      location: json['location'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      organizerId: json['organizerId'],
      tickets: (json['tickets'] as List)
          .map((e) => TicketModel.fromJson(e))
          .toList(),
      isFeatured: json['isFeatured'] ?? false,
      status: EventStatus.values.byName(
        json['status'] ?? 'pending',
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eventDate': eventDate.toIso8601String(),
      'location': location,
      'imageUrl': imageUrl,
      'category': category,
      'organizerId': organizerId,
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'isFeatured': isFeatured,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}