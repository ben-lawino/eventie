import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset('assets/icons/applogo.png'),
        title: Text('Tickets',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/search.png', scale: 25, color: Colors.grey[700],),
          ),
        ],
        //centerTitle: true,
      ),
    );
  }
}
