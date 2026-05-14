import 'package:eventie/customer/providers/booking_provider.dart';
import 'package:eventie/widgets/cancelled_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../data/dummy_data.dart';

class Cancelled extends ConsumerWidget {
  const Cancelled({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingProvider);

    // ONLY cancelled bookings
    final cancelledBookings = bookings
        .where((b) => b.status == 'cancelled')
        .toList();

    return Scaffold(
      body: cancelledBookings.isEmpty
          ? const Center(
        child: Text(
          "No cancelled bookings",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cancelledBookings.length,
        itemBuilder: (context, index) {
          final booking = cancelledBookings[index];

          final event = dummyEvents.firstWhere(
                (e) => e.id == booking.eventId,
            orElse: () => dummyEvents[0],
          );

          return CancelledCard(
              imageUrl:
              event.imageUrl ?? 'https://via.placeholder.com/150',

              title: event.title,

              date: DateFormat('EEE, MMM d, HH:mm')
                  .format(event.eventDate),

              location: event.location,
          );
        },
      ),
    );
  }
}