import 'package:eventie/customer/screens/profile.dart';
import 'package:eventie/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          title: 'Notification Settings', backDestination: ProfilePage()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Toggles
              SettingTile(
                title: "Enable Notifications",
                value: false,
              ),

              SettingTile(
                title: "Ticket Updates",
                value: true,
              ),

              SettingTile(
                title: "Event Recommendations",
                value: true,
              ),

              SettingTile(
                title: "Promotions",
                value: false,
              ),

              SettingTile(
                title: "App Updates",
                value: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
