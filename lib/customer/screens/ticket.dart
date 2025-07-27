import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../widgets/booking_card.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
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
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Upcoming')),
              Tab(child: Text('Completed')),
              Tab(child: Text('Cancelled')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
          ],
        ),
      ),
    );
  }
}
