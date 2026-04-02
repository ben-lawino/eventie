import 'package:eventie/data/models/ticket_model.dart';



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

  final String status; // pending, approved, rejected

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
    this.status = 'pending',
    required this.createdAt,
    required this.updatedAt,
  });

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
      status: json['status'] ?? 'pending',
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
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}