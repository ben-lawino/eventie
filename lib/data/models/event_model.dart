
import 'package:eventie/data/models/ticket_model.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String imageUrl;
  final String category;
  final String organizerId;
  final List<TicketModel> tickets; // 👈 Here it integrates
  final bool isFeatured;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.category,
    required this.organizerId,
    required this.tickets,
    required this.isFeatured,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      organizerId: json['organizerId'],
      tickets: (json['tickets'] as List)
          .map((e) => TicketModel.fromJson(e))
          .toList(),
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'imageUrl': imageUrl,
      'category': category,
      'organizerId': organizerId,
      'tickets': tickets.map((e) => e.toJson()).toList(),
      'isFeatured': isFeatured,
    };
  }
}
