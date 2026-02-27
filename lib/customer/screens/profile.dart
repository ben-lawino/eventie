import 'package:eventie/customer/navigation.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/data/categories.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          color: Colors.grey[700],
        ),
        title: Text(
          'Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/hacker.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ben Lawin',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
            ),
            ListTile(
              leading: Image.asset('assets/icons/calendar.png', scale: 24),
              title: Text(
                'Manage Events',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
            ),
            ListTile(
              leading: Image.asset('assets/icons/user_outlined.png', scale: 24),
              title: Text(
                'Profile',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset('assets/icons/notification.png', scale: 24),
              title: Text(
                'Notification',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset('assets/icons/payment.png', scale: 24),
              title: Text(
                'Payments',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset('assets/icons/security.png', scale: 24),
              title: Text(
                'Security',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
            ),
            SwitchListTile(
              value: false,
              onChanged: (value) {},
              title: Text(
                'Dark Mode',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              secondary: Image.asset('assets/icons/moon.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset('assets/icons/language.png', scale: 24),
              title: Text(
                'Language',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset('assets/icons/help.png', scale: 24),
              title: Text(
                'Help Center',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset('assets/icons/friends.png', scale: 24),
              title: Text(
                'Invite Friends',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset('assets/icons/star.png', scale: 24),
              title: Text(
                'Rate us',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/exit.png',
                scale: 24,
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
