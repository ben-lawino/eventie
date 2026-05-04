import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/dummy_data.dart';
import '../../../widgets/booking_card.dart';
import '../../../widgets/cancel_event.dart';
import '../../providers/booking_provider.dart';
import 'package:intl/intl.dart';

class Upcoming extends ConsumerStatefulWidget {
  const Upcoming({super.key});

  @override
  ConsumerState<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends ConsumerState<Upcoming> {
  void _openCancelEventOverlay(BuildContext context, String bookingId) {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      context: context,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: CancelEvent(bookingId: bookingId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingProvider);

    // upcoming logic
    final upcomingBookings = bookings.where((b) {
      final event = dummyEvents.firstWhere(
            (e) => e.id == b.eventId,
        orElse: () => dummyEvents[0],
      );

      return b.status != 'cancelled' &&
          event.eventDate.isAfter(DateTime.now());
    }).toList();

    return Scaffold(
      body: upcomingBookings.isEmpty
          ? const Center(
        child: Text(
          "No upcoming bookings",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: upcomingBookings.length,
        itemBuilder: (context, index) {
          final booking = upcomingBookings[index];

          final event = dummyEvents.firstWhere(
                (e) => e.id == booking.eventId,
            orElse: () => dummyEvents[0],
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookingCard(
              onCancelBooking: () {
                _openCancelEventOverlay(context, booking.id);
              },
              imageUrl:
              event.imageUrl ?? 'https://via.placeholder.com/150',
              title: event.title,

              // show event date, not booking date
              date: DateFormat('EEE, MMM d, HH:mm')
                  .format(event.eventDate),

              location: event.location,
            ),
          );
        },
      ),
    );
  }
}