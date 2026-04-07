import 'package:eventie/customer/navigation.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/customer/screens/tab_screens/cancelled.dart';
import 'package:eventie/customer/screens/tab_screens/completed.dart';
import 'package:eventie/customer/screens/tab_screens/upcoming.dart';
import 'package:eventie/data/categories.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

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
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
              );
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            'Tickets',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            padding: EdgeInsets.only(right: 18, left: 18,bottom: 18),
            indicatorWeight: 3.5,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(child: Text('Upcoming')),
              Tab(child: Text('Completed')),
              Tab(child: Text('Cancelled')),
            ],
          ),
        ),
        body: TabBarView(children: [Upcoming(), Completed(), Cancelled()]),
      ),
    );
  }
}
