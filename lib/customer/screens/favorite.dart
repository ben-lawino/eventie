import 'package:eventie/customer/navigation.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/data/categories.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/dummy_data.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final event = dummyEvents[0];
    final formattedDate = DateFormat('EEE, MMM d, HH:mm').format(event.date);

    return Scaffold(
      appBar: CustomAppBar(title: 'Favorites',backDestination: NavigationMenu(),),
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
