import 'package:eventie/customer/navigation.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/customer/screens/tab_screens/cancelled.dart';
import 'package:eventie/customer/screens/tab_screens/completed.dart';
import 'package:eventie/customer/screens/tab_screens/upcoming.dart';
import 'package:eventie/data/categories.dart';
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
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
              );
            },
            child: Image.asset('assets/icons/applogo.png'),
          ),
          title: Text(
            'Tickets',
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
            padding: EdgeInsets.symmetric(horizontal: 18),
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
