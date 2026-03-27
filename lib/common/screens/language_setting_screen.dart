import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../customer/screens/profile.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Language ',
        backDestination: ProfilePage(),
      ),
    );
  }
}
