import 'package:eventie/customer/navigation.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/data/categories.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.grey[700],
        ),
        title: Text(
          'Notifications',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Image.asset('assets/icons/menu.png', scale: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                ListTile(
                  leading: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/calendar.png',
                        scale: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  title: Text(
                    'Booking Successful!',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '20 Dec 2025 | 20:49 PM',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'New',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    'You have successfully booked the Art workshops.The event will be held on Sunday,December 22, 2022, 13:00 - 14:00 PM.Don\'t forget to activate your reminder.Enjoy the Event!',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 11,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent.withOpacity(0.15)
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/user_filled.png',
                        scale: 30,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  title: Text(
                    'Account Setup Successful!',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '20 Dec 2025 | 20:49 PM',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    'Your account creation is successful, you can experience our services!',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 11,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
