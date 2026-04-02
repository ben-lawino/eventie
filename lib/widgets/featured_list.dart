import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../customer/providers/favorites_provider.dart';
import '../customer/screens/details.dart';
import '../data/models/event_model.dart';

import 'card.dart';

class EventsList extends ConsumerWidget {
  final List<EventModel> dummyEvents;

  const EventsList({super.key, required this.dummyEvents});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return SizedBox(
      height: 380,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dummyEvents.length,
        itemBuilder: (context, index) {
          final event = dummyEvents[index];

          final formattedDate =
          DateFormat('EEE, MMM d, HH:mm').format(event.eventDate); // ✅ fix here if needed

          final isFav = favorites.contains(event.id);

          return SizedBox(
            width: 300,
            child: EventCard(
              imageUrl:
              event.imageUrl ?? 'https://via.placeholder.com/150',
              title: event.title,
              date: formattedDate,
              location: event.location,
              isFavorite: isFav, // ✅ REQUIRED

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(event: event),
                  ),
                );
              },

              onFavorite: () {
                ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(event.id);
              },
            ),
          );
        },
      ),
    );
  }
}