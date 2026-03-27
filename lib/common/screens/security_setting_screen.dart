import 'package:eventie/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

import '../../customer/screens/profile.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_app_bar.dart';

class SecuritySettingScreen extends StatelessWidget {
  const SecuritySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: const CustomAppBar(
            title: 'Security Settings', backDestination: ProfilePage()),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SettingTile(
                title: "Remember me",
                value: true,
              ),
              const SettingTile(
                title: 'Biometric ID',
                value: true,
              ),
              const SizedBox(height: 25),
              Button(
                  width: double.infinity,
                  color: Colors.deepPurple.withOpacity(0.15),
                  textColor: primaryColor,
                  onPressed: () {},
                  text: "Change PIN"),
              const SizedBox(height: 12),
              Button(
                  width: double.infinity,
                  color: Colors.deepPurple.withOpacity(0.15),
                  textColor: primaryColor,
                  onPressed: () {},
                  text: "Change Password"),
            ],
          ),
        ));
  }
}
