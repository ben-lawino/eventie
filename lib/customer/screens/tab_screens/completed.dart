import 'package:eventie/customer/providers/booking_provider.dart';
import 'package:eventie/widgets/completed_card.dart';
import 'package:eventie/widgets/rate_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../data/dummy_data.dart';

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

    final completedBookings = bookings.where((b) {
      final event = dummyEvents.firstWhere(
            (e) => e.id == b.eventId,
        orElse: () => dummyEvents[0],
      );

      return b.status != 'cancelled' &&
          event.eventDate.isBefore(DateTime.now());
    }).toList();

    return Scaffold(
      body: completedBookings.isEmpty
          ? const Center(
        child: Text(
          "No Completed bookings",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: completedBookings.length,
        itemBuilder: (context, index) {
          final booking = completedBookings[index];

          final event = dummyEvents.firstWhere(
                (e) => e.id == booking.eventId,
            orElse: () => dummyEvents[0],
          );

          return CompletedCard(
            onRateEvent: () {
              _openRateEventOverlay(context, booking.id);
            },

            imageUrl:
            event.imageUrl ?? 'https://via.placeholder.com/150',

            title: event.title,

            // use event date, not booking date
            date: DateFormat('EEE, MMM d, HH:mm')
                .format(event.eventDate),

            location: event.location,
          );
        },
      ),
    );
  }
}