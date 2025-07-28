import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';
import '../../../widgets/completed_card.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    final event = dummyEvents[0];
    final formattedDate = DateFormat(
      'EEE, MMM d, HH:mm',
    ).format(event.date);

    return Scaffold(
      body: ListView(
          children: [
            CompletedCard(
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
