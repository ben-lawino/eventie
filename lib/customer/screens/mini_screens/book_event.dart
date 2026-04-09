import 'package:eventie/data/models/event_model.dart';
import 'package:flutter/material.dart';
import '../tab_screens/economy.dart';

class BookEvent extends StatefulWidget {
  final EventModel event;

  const BookEvent({super.key, required this.event});

  @override
  State<BookEvent> createState() => _BookEventState();
}

class _BookEventState extends State<BookEvent> {
  @override
  Widget build(BuildContext context) {
    final tickets = widget.event.tickets;

    return DefaultTabController(
      length: tickets.length, // dynamic
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(
            'Book Event',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,

          // DYNAMIC TAB BAR
          bottom: TabBar(
            indicatorWeight: 3.5,
            indicatorSize: TabBarIndicatorSize.tab,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            tabs: tickets.map((ticket) {
              return Tab(
                child: Text(
                  ticket.type,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // DYNAMIC TAB VIEW
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: TabBarView(
            children: tickets.map((ticket) {
              return Economy(
                event: widget.event,
                ticket: ticket,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}