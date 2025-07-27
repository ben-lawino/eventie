import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../widgets/booking_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
