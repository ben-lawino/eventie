import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/dummy_data.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/favorite_card.dart';
import '../navigation.dart';
import '../providers/favorites_provider.dart';
import 'details.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesProvider);

    final favoriteEvents = dummyEvents
        .where((event) => favoriteIds.contains(event.id))
        .toList();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorites',
        backDestination: NavigationMenu(),
      ),
      body: favoriteEvents.isEmpty
          ? const Center(
        child: Text('No favorites yet ❤'),
      )
          : ListView.builder(
        itemCount: favoriteEvents.length,
        itemBuilder: (context, index) {
          final event = favoriteEvents[index];

          final formattedDate =
          DateFormat('EEE, MMM d, HH:mm')
              .format(event.eventDate); // adjust field if needed

          return FavoriteCard(
            eventId: event.id,
            imageUrl: event.imageUrl ??
                'https://via.placeholder.com/150',
            title: event.title,
            date: formattedDate,
            location: event.location,

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(event: event),
                ),
              );
            },
          );
        },
      ),
    );
  }
}