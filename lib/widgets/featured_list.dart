import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/models/event_model.dart';
import 'card.dart';

class EventsList extends StatelessWidget {
  final List<EventModel> dummyEvents;

  const EventsList({Key? key, required this.dummyEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dummyEvents.length,
        itemBuilder: (context, index) {
          final event = dummyEvents[index];
          final formattedDate = DateFormat(
            'EEE, MMM d, HH:mm',
          ).format(event.date);

          return SizedBox(
            width: 300,
            child: EventCard(
              imageUrl: event.imageUrl,
              title: event.title,
              date: formattedDate,
              location: event.location,
            ),
          );
        },
      ),
    );
  }
}
