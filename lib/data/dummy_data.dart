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
    'https://images.unsplash.com/photo-1678646142794-253fdd20fa05?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZCUyMGZlc3RpdmFsfGVufDB8fDB8fHww&fm=jpg&q=60&w=3000',
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
    'https://images.stockcake.com/public/c/3/4/c349a7f9-4b10-48f2-ace4-7b081d341ad3_large/tech-expo-event-stockcake.jpg',
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
    'https://plus.unsplash.com/premium_photo-1661377118520-287ec60a32f3?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8d29yc2hpcHxlbnwwfHwwfHx8MA%3D%3D&fm=jpg&q=60&w=3000',
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
