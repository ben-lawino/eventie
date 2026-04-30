import 'package:eventie/customer/providers/booking_provider.dart';
import 'package:eventie/widgets/completed_card.dart';
import 'package:eventie/widgets/rate_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
class Completed extends ConsumerWidget {
  const Completed({super.key});

  void _openRateEventOverlay(BuildContext context, String bookingId) {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      context: context,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: RateEvent(bookingId: bookingId),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingProvider);

    final completedBookings = bookings
        .where((b) => b.status == 'completed')
        .toList();

    return Scaffold(
      body: completedBookings.isEmpty
          ? const Center(
        child: Text(
          "No Completed bookings",
          style: TextStyle(fontSize: 16),
        )
      ):
      ListView.builder(
        itemCount: completedBookings.length,
        itemBuilder: (context, index) {
          final booking = completedBookings[index];

          return CompletedCard(
            onRateEvent: () {
              _openRateEventOverlay(context, booking.id);
            },
            imageUrl: 'https://via.placeholder.com/150',
            title: booking.eventId,
            date: DateFormat('EEE, MMM d, HH:mm')
                .format(booking.bookedAt),
            location: 'Event location',
          );
        },
      ),
    );
  }
}