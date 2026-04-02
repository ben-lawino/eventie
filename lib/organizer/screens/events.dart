import 'package:eventie/organizer/screens/tabscreens/cancelled_event.dart';
import 'package:eventie/organizer/screens/tabscreens/completed_event.dart';
import 'package:eventie/organizer/screens/tabscreens/pending_event.dart';
import 'package:eventie/organizer/screens/tabscreens/upcoming_event.dart';
import 'package:flutter/material.dart';

import '../bottom_nav.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BottomNav()),
              );
            },
            icon: Icon(Icons.arrow_back_rounded),
            color: Colors.grey[700],
          ),
          title: Text(
            'Events',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: 18),
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(child: Text('Pending',style : Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700
              )),),
              Tab(child: Text('Upcoming',style : Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700
              ))),
              Tab(child: Text('Done',style : Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700
              ))),
              Tab(child: Text('Cancelled',style : Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700)
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PendingEventsScreen(),
            UpcomingEventScreen(),
            CompletedEventScreen(),
            CancelledEventScreen(),
          ],
        ),
      ),
    );
  }
}
