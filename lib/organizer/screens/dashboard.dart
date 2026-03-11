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
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2,
                children: [
                  dashboardItem(
                    context: context,
                    title: "Total Events",
                    value: "12",
                    color: primaryColor,
                  ),
                  dashboardItem(
                    context: context,
                    title: "Tickets Sold",
                    value: "1667",
                    color: primaryColor,
                  ),
                  dashboardItem(
                    context: context,
                    title: "Approved",
                    value: "5",
                    color: primaryColor,
                  ),
                  dashboardItem(
                    context: context,
                    title: "Completed",
                    value: "1",
                    color: primaryColor,
                  ),
                ],
              ),
            ),

            // Revenue container
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revenue',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ksh 230,000',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/activity.png',
                          scale: 30,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    title: Text(
                      '20 new tickets sold',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/activity.png',
                          scale: 30,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    title: Text(
                      'Events approved',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/activity.png',
                          scale: 30,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    title: Text(
                      'Payout of Ksh 5,000 processed',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/activity.png',
                          scale: 30,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    title: Text(
                      'Payout of Ksh 5,000 processed',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}


Widget dashboardItem({
  required BuildContext context,
  required String title,
  required String value,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 25,
          ),
        ),
      ],
    ),
  );
}