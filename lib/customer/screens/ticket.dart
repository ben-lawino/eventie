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
        appBar: CustomAppBar(
          title: 'Tickets',
          backDestination: NavigationMenu(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Image.asset(
                'assets/icons/search.png',
                scale: 25,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        body: TabBarView(children: [Upcoming(), Completed(), Cancelled()]),
      ),
    );
  }
}
