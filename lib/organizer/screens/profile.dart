import 'package:eventie/organizer/bottom_nav.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
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
          'Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: primaryColor.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ClipOval(
                      child: Image.asset('assets/images/profilepic.png'),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ben lawin',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'verified organizer',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey[400], thickness: 1, height: 20),
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
              leading: Image.asset('assets/icons/security.png', scale: 24),
              title: Text(
                'Security',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
            ),
            Divider(color: Colors.grey[400], thickness: 1, height: 20),
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
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
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
            Divider(color: Colors.grey[400], thickness: 1, height: 20),
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
