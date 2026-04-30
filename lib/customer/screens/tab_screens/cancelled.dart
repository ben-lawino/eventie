import 'package:eventie/customer/providers/booking_provider.dart';
import 'package:eventie/widgets/cancelled_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Cancelled extends ConsumerWidget {
  const Cancelled({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingProvider);

    // Filter cancelled bookings
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

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CancelledCard(
              imageUrl:
              'https://via.placeholder.com/150',
              title: booking.eventId,
              date: DateFormat('EEE, MMM d, HH:mm')
                  .format(booking.bookedAt),
              location: 'Event location',
            ),
          );
        },
      ),
    );
  }
}