import 'models/event_model.dart';
import 'models/ticket_model.dart';

final List<EventModel> dummyEvents = [
  EventModel(
    id: 'event001',
    title: 'Nairobi Food & Music Festival',
    description:
    'Experience the best of Kenyan cuisine and live performances by top local artists.',
    date: DateTime.parse('2025-12-24T18:00:00Z'),
    location: 'KICC Grounds, Nairobi',
    imageUrl:
    'https://images.unsplash.com/photo-1547045662-6ce7c1f2ed6c?fit=crop&w=800',
    category: 'Festival',
    organizerId: 'organizer123',
    isFeatured: true,
    tickets: [
      TicketModel(
        id: 'ticket001',
        eventId: 'event001',
        type: 'regular',
        price: 1000.0,
        totalQuantity: 500,
        soldQuantity: 220,
      ),
      TicketModel(
        id: 'ticket002',
        eventId: 'event001',
        type: 'vip',
        price: 3000.0,
        totalQuantity: 200,
        soldQuantity: 110,
      ),
    ],
  ),
  EventModel(
    id: 'event002',
    title: 'Tech Expo Nairobi 2025',
    description:
    'Discover innovative startups, attend keynotes, and connect with Kenya’s tech ecosystem.',
    date: DateTime.parse('2025-11-15T10:00:00Z'),
    location: 'Sarit Expo Centre, Nairobi',
    imageUrl:
    'https://images.unsplash.com/photo-1551836022-d5d88e9218df?fit=crop&w=800',
    category: 'Tech',
    organizerId: 'organizer456',
    isFeatured: false,
    tickets: [
      TicketModel(
        id: 'ticket003',
        eventId: 'event002',
        type: 'regular',
        price: 500.0,
        totalQuantity: 300,
        soldQuantity: 150,
      ),
      TicketModel(
        id: 'ticket004',
        eventId: 'event002',
        type: 'vip',
        price: 1200.0,
        totalQuantity: 100,
        soldQuantity: 40,
      ),
    ],
  ),
  EventModel(
    id: 'event003',
    title: 'Gospel Night Live',
    description:
    'A night of praise, worship, and inspiration with top gospel artists.',
    date: DateTime.parse('2025-10-07T19:00:00Z'),
    location: 'Kenyatta University Amphitheatre',
    imageUrl:
    'https://images.unsplash.com/photo-1515169067865-5387a1e2555e?fit=crop&w=800',
    category: 'Concert',
    organizerId: 'organizer789',
    isFeatured: true,
    tickets: [
      TicketModel(
        id: 'ticket005',
        eventId: 'event003',
        type: 'regular',
        price: 800.0,
        totalQuantity: 250,
        soldQuantity: 180,
      ),
      TicketModel(
        id: 'ticket006',
        eventId: 'event003',
        type: 'vvip',
        price: 3000.0,
        totalQuantity: 30,
        soldQuantity: 25,
      ),
    ],
  ),
];
