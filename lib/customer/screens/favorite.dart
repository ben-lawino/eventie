import 'package:eventie/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/dummy_data.dart';
import '../../widgets/booking_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = dummyEvents[0];
    final formattedDate = DateFormat('EEE, MMM d, HH:mm').format(event.date);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset('assets/icons/applogo.png'),
        title: Text(
          'Favorites',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/search.png',
              scale: 25,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          FavoriteCard(
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
