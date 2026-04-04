import 'package:eventie/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../customer/providers/favorites_provider.dart';
import '../data/models/event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SmallEventList extends ConsumerWidget {
  final List<EventModel> dummyEvents;

  const SmallEventList({super.key, required this.dummyEvents});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75, // control card height
        ),
        itemCount: dummyEvents.length,
        itemBuilder: (context, index) {
          final event = dummyEvents[index];
          final formattedDate = DateFormat(
            'EEE, MMM d, HH:mm',
          ).format(event.eventDate);
          final isFav = favorites.contains(event.id);

          return GridCard(
            isFavorite: isFav,
            event: event,
            imageUrl: event.imageUrl ?? 'https://via.placeholder.com/150',
            title: event.title,
            date: formattedDate,
            location: event.location,
            onFavorite: () {
              ref
                  .read(favoritesProvider.notifier)
                  .toggleFavorite(event.id);
            },
          );
        },
      ),
    );
  }
}
