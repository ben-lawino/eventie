import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';
import '../../../widgets/booking_card.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({super.key});


  @override
  Widget build(BuildContext context) {
    final event = dummyEvents[0];
    final formattedDate = DateFormat(
      'EEE, MMM d, HH:mm',
    ).format(event.date);

    return Scaffold(
      body: ListView(
        children: [
          BookingCard(
            imageUrl: event.imageUrl,
            title: event.title,
            date: formattedDate,
            location: event.location,
          ),
        ]
      ),
    );
  }
}
