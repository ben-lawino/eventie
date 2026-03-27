import 'package:eventie/common/login/create_new_password.dart';
import 'package:eventie/common/login/forgot_password.dart';
import 'package:eventie/common/login/sign_up.dart';
import 'package:eventie/common/login/signin.dart';
import 'package:eventie/customer/navigation.dart';
import 'package:eventie/organizer/bottom_nav.dart';
import 'package:eventie/organizer/screens/mini/create_event.dart';
import 'package:eventie/widgets/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/login/otp_verification_screen.dart';
import 'common/login/welcome_screen.dart';
import 'common/theme/app_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Eventie',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: CreateNewPasswordScreen(),
    );
  }
}
