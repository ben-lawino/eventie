import 'package:eventie/customer/navigation.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/data/categories.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/log_out.dart';
import 'package:flutter/material.dart';

import '../../common/screens/edit_profile.dart';
import '../../common/screens/help_center_screen.dart';
import '../../common/screens/language_setting_screen.dart';
import '../../common/screens/notification_setting_screen.dart';
import '../../common/screens/security_setting_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _logOutOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      context: context,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.28,
        child: LogOut(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', backDestination: NavigationMenu()),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        'assets/images/profilepic.png',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ben lawin',
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
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                  height: 20,
                ),
              ),

              //Fields
              ListTile(
                leading: Image.asset('assets/icons/calendar.png', scale: 24),
                title: Text(
                  'Manage Events',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                  height: 20,
                ),
              ),

              //profile
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                },
                child: ListTile(
                  leading: Image.asset(
                    'assets/icons/user_outlined.png',
                    scale: 24,
                  ),
                  title: Text(
                    'Profile',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  trailing:
                      Image.asset('assets/icons/arrowright.png', scale: 24),
                ),
              ),

              //notification
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationSettingScreen()));
                },
                child: ListTile(
                  leading: Image.asset(
                    'assets/icons/notification.png',
                    scale: 24,
                  ),
                  title: Text(
                    'Notification',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  trailing:
                      Image.asset('assets/icons/arrowright.png', scale: 24),
                ),
              ),

              //payments
              ListTile(
                leading: Image.asset('assets/icons/payment.png', scale: 24),
                title: Text(
                  'Payments',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
              ),

              //security
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecuritySettingScreen()));
                },
                child: ListTile(
                  leading: Image.asset('assets/icons/security.png', scale: 24),
                  title: Text(
                    'Security',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  trailing:
                      Image.asset('assets/icons/arrowright.png', scale: 24),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                  height: 20,
                ),
              ),

              //darkmode
              SwitchListTile(
                value: false,
                onChanged: (value) {},
                title: Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                secondary: Image.asset('assets/icons/moon.png', scale: 24),
                activeColor: Colors.white,
                activeTrackColor: primaryColor,
              ),

              //Language
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageSettingScreen()));
                },
                child: ListTile(
                  leading: Image.asset('assets/icons/language.png', scale: 24),
                  title: Text(
                    'Language',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  trailing:
                      Image.asset('assets/icons/arrowright.png', scale: 24),
                ),
              ),

              //help
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpCenterScreen(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.asset('assets/icons/help.png', scale: 24),
                  title: Text(
                    'Help Center',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  trailing:
                      Image.asset('assets/icons/arrowright.png', scale: 24),
                ),
              ),

              //invite friends
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
              ),

              //logOUt
              GestureDetector(
                onTap: _logOutOverlay,
                child: ListTile(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
