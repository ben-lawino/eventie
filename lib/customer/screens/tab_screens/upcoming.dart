import 'package:eventie/customer/providers/booking_provider.dart';
import 'package:eventie/widgets/cancel_event.dart';
import 'package:eventie/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';

class Upcoming extends ConsumerStatefulWidget {
  const Upcoming({super.key});

  @override
  ConsumerState<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends ConsumerState<Upcoming> {
  void _openCancelEventOverlay(BuildContext context, String bookingId) {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: false,
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

    //Filter upcoming bookings
    final upcomingBookings = bookings
        .where((b) => b.status == 'paid') // adjust if needed
        .toList();

    final event = dummyEvents[0];
    final formattedDate =
        DateFormat('EEE, MMM d, HH:mm').format(event.eventDate);


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

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BookingCard(
                    onCancelBooking: () {
                      _openCancelEventOverlay(context, booking.id);
                    },
                    imageUrl:
                        event.imageUrl ?? 'https://via.placeholder.com/150',
                    title: event.title,
                    date: DateFormat('EEE, MMM d, HH:mm')
                        .format(booking.bookedAt),
                    location: 'Event location', // to be replaced later
                  ),
                );
              },
            ),
    );
  }
}
