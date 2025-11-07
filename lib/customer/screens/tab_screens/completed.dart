import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';
import '../../../widgets/completed_card.dart';
import '../../../widgets/rate_event.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  void _openRateEventOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      context: context,
      builder: (ctx) =>
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.35,
            child: RateEvent(),
          ),
    );
  }
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
              onRateEvent: _openRateEventOverlay,
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
