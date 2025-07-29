import 'package:eventie/customer/screens/mini_screens/cancel_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';
import '../../../widgets/booking_card.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  void _openCancelEventOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      context: context,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: CancelEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = dummyEvents[0];
    final formattedDate = DateFormat('EEE, MMM d, HH:mm').format(event.date);

    return Scaffold(
      body: ListView(
        children: [
          BookingCard(
            onCancelBooking: _openCancelEventOverlay,
            imageUrl: event.imageUrl,
            title: event.title,
            date: formattedDate,
            location: event.location,
          ),
        ],
      ),
    );
  }
}
