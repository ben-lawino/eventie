import 'package:flutter/material.dart';

import '../../customer/screens/mini_screens/notification.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: const AssetImage('assets/images/hacker.png'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning',
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: Colors.grey),
            ),
            Text(
              'Ben lawin',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              icon: Image.asset(
                'assets/icons/notification.png',
                width: 25,
                height: 25,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: width*0.43,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(18)
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 100,
                  width: width*0.43,
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
