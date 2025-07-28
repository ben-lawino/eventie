import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';
import '../../../widgets/cancelled_card.dart';

class Cancelled extends StatelessWidget {
  const Cancelled({super.key});

  @override
  Widget build(BuildContext context) {
    final event = dummyEvents[0];
    final formattedDate = DateFormat(
      'EEE, MMM d, HH:mm',
    ).format(event.date);

    return Scaffold(
      body: ListView(
          children: [
            CancelledCard(
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