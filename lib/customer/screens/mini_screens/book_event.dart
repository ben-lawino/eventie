import 'package:flutter/material.dart';

import '../tab_screens/economy.dart';
import '../tab_screens/vip.dart';

class BookEvent extends StatelessWidget {
  const BookEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Book Event',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorWeight: 3.5,
            indicatorSize: TabBarIndicatorSize.tab,
            padding: EdgeInsets.symmetric(horizontal: 18),
            tabs: [
              Tab(
                child: Text(
                  'Economy',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'VIP',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: TabBarView(children: [Economy(), Vip()]),
        ),
      ),
    );
  }
}
