import 'package:flutter/material.dart';
import '../../../data/models/event_model.dart';
import '../../../data/models/ticket_model.dart';
import '../../../widgets/button.dart';
import '../mini_screens/book_event_detail.dart';

class Economy extends StatefulWidget {
  final EventModel event;
  final TicketModel ticket;

  const Economy({super.key,
    required this.event,
    required this.ticket,
  });

  @override
  State<Economy> createState() => _EconomyState();
}

class _EconomyState extends State<Economy> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.ticket.price * _counter;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Choose number of tickets',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _decrementCounter,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.asset(
                      'assets/icons/minus.png',
                      scale: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Text(
                 '$_counter',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: _incrementCounter,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.asset(
                      'assets/icons/add.png',
                      scale: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookEventDetail(
                    event: widget.event,
                    ticket: widget.ticket,
                    quantity: _counter,
                    total: total,
                  )),
                );
              },
              text: 'Continue - Ksh. $total',
              width: double.infinity,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
