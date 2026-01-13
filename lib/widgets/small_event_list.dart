import 'package:eventie/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/models/event_model.dart';

class SmallEventList extends StatelessWidget {
  final List<EventModel> dummyEvents;

  const SmallEventList({super.key, required this.dummyEvents});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8, // Adjust this to control card height
        ),
        itemCount: dummyEvents.length,
        itemBuilder: (context, index) {
          final event = dummyEvents[index];
          final formattedDate = DateFormat(
            'EEE, MMM d, HH:mm',
          ).format(event.date);

          return GridCard(
            event: event,
            imageUrl: event.imageUrl,
            title: event.title,
            date: formattedDate,
            location: event.location,
            onFavorite: () {},
          );
        },
      ),
    );
  }
}
