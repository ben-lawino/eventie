import 'models/event_model.dart';
import 'models/ticket_model.dart';

final List<EventModel> dummyEvents = [
  EventModel(
    id: 'event001',
    title: 'Nairobi Food & Music Festival',
    description: 'Experience the best of Kenyan cuisine and live performances.',
    eventDate: DateTime.now().add(const Duration(days: 5)), // UPCOMING
    location: 'KICC Grounds, Nairobi',
    imageUrl: 'https://images.pexels.com/photos/36565760/pexels-photo-36565760.jpeg',
    category: 'Music',
    organizerId: 'organizer123',
    isFeatured: true,
    status: 'approved',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket001',
        type: 'regular',
        price: 1000.0,
        quantity: 500,
        sold: 220,
      ),
      TicketModel(
        id: 'ticket002',
        type: 'vip',
        price: 3000.0,
        quantity: 200,
        sold: 110,
      ),
    ],
  ),

  EventModel(
    id: 'event002',
    title: 'Tech Expo Nairobi 2025',
    description: 'Discover startups and connect with Kenya’s tech ecosystem.',
    eventDate: DateTime.now().add(const Duration(hours: 6)), // UPCOMING
    location: 'Sarit Expo Centre',
    imageUrl: 'https://images.unsplash.com/photo-1556761175-4b46a572b786',
    category: 'Tech',
    organizerId: 'organizer456',
    isFeatured: false,
    status: 'pending',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket003',
        type: 'regular',
        price: 500.0,
        quantity: 300,
        sold: 150,
      ),
      TicketModel(
        id: 'ticket004',
        type: 'vip',
        price: 1200.0,
        quantity: 100,
        sold: 40,
      ),
    ],
  ),

  EventModel(
    id: 'event003',
    title: 'Gospel Night Live',
    description: 'A night of praise and worship.',
    eventDate: DateTime.now().add(const Duration(days: 10)), // UPCOMING
    location: 'Kenyatta University Amphitheatre',
    imageUrl: 'https://images.pexels.com/photos/15672801/pexels-photo-15672801.jpeg',
    category: 'Community',
    organizerId: 'organizer789',
    isFeatured: true,
    status: 'approved',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket005',
        type: 'regular',
        price: 800.0,
        quantity: 250,
        sold: 180,
      ),
      TicketModel(
        id: 'ticket006',
        type: 'vvip',
        price: 3000.0,
        quantity: 30,
        sold: 25,
      ),
    ],
  ),

  EventModel(
    id: 'event004',
    title: 'Nairobi Fashion Week',
    description: 'Top African designers showcase their collections.',
    eventDate: DateTime.now().subtract(const Duration(days: 2)), // COMPLETED
    location: 'Two Rivers Mall',
    imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d',
    category: 'Fashion',
    organizerId: 'organizer321',
    isFeatured: false,
    status: 'approved',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket007',
        type: 'regular',
        price: 1500.0,
        quantity: 200,
        sold: 90,
      ),
    ],
  ),

  EventModel(
    id: 'event005',
    title: 'Startup Pitch Night',
    description: 'Startups pitch ideas to investors.',
    eventDate: DateTime.now().add(const Duration(days: 3)), // UPCOMING
    location: 'iHub Nairobi',
    imageUrl: 'https://images.pexels.com/photos/7414268/pexels-photo-7414268.jpeg',
    category: 'Business',
    organizerId: 'organizer654',
    isFeatured: false,
    status: 'pending',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket008',
        type: 'regular',
        price: 300.0,
        quantity: 150,
        sold: 60,
      ),
    ],
  ),

  EventModel(
    id: 'event006',
    title: 'Comedy Night Nairobi',
    description: 'Stand-up comedy with top Kenyan comedians.',
    eventDate: DateTime.now().subtract(const Duration(days: 5)), // COMPLETED
    location: 'Carnivore Grounds',
    imageUrl: 'https://images.pexels.com/photos/19275019/pexels-photo-19275019.jpeg',
    category: 'Art & Culture',
    organizerId: 'organizer987',
    isFeatured: true,
    status: 'approved',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket009',
        type: 'regular',
        price: 700.0,
        quantity: 400,
        sold: 250,
      ),
    ],
  ),

  EventModel(
    id: 'event007',
    title: 'Art & Culture Exhibition',
    description: 'Explore African art, crafts, and cultural heritage.',
    eventDate: DateTime.now().subtract(const Duration(days: 10)), // COMPLETED
    location: 'Nairobi National Museum',
    imageUrl: 'https://images.pexels.com/photos/35912971/pexels-photo-35912971.jpeg',
    category: 'Art & Culture',
    organizerId: 'organizer111',
    isFeatured: false,
    status: 'approved',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket010',
        type: 'regular',
        price: 400.0,
        quantity: 200,
        sold: 120,
      ),
    ],
  ),

  EventModel(
    id: 'event008',
    title: 'Fitness Bootcamp',
    description: 'Outdoor workout session with professional trainers.',
    eventDate: DateTime.now().subtract(const Duration(days: 1)), // COMPLETED
    location: 'Uhuru Park',
    imageUrl: 'https://images.pexels.com/photos/9958670/pexels-photo-9958670.jpeg',
    category: 'Wellness',
    organizerId: 'organizer222',
    isFeatured: false,
    status: 'pending',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket011',
        type: 'regular',
        price: 200.0,
        quantity: 100,
        sold: 30,
      ),
    ],
  ),

  EventModel(
    id: 'event009',
    title: 'DJ Night Party',
    description: 'Dance all night with top DJs in Nairobi.',
    eventDate: DateTime.now().subtract(const Duration(days: 20)), // COMPLETED
    location: 'Westlands Club',
    imageUrl: 'https://images.pexels.com/photos/5152573/pexels-photo-5152573.jpeg',
    category: 'Music',
    organizerId: 'organizer333',
    isFeatured: true,
    status: 'approved',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket012',
        type: 'regular',
        price: 1000.0,
        quantity: 300,
        sold: 210,
      ),
      TicketModel(
        id: 'ticket013',
        type: 'vip',
        price: 2500.0,
        quantity: 100,
        sold: 80,
      ),
    ],
  ),

  EventModel(
    id: 'event010',
    title: 'Film Premiere Night',
    description: 'Exclusive screening of a new Kenyan film.',
    eventDate: DateTime.now().subtract(const Duration(days: 30)), // COMPLETED
    location: 'Century Cinemax',
    imageUrl: 'https://images.pexels.com/photos/7991126/pexels-photo-7991126.jpeg',
    category: 'Art & Culture',
    organizerId: 'organizer444',
    isFeatured: false,
    status: 'approved',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    tickets: [
      TicketModel(
        id: 'ticket014',
        type: 'regular',
        price: 800.0,
        quantity: 150,
        sold: 140,
      ),
    ],
  ),
];