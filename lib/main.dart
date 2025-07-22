import 'package:eventie/customer/navigation.dart';
import 'package:eventie/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/theme/app_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // or match Scaffold background
    statusBarIconBrightness: Brightness.dark, // adjust to your design
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Eventie',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
      home: NavigationMenu(),
    );
  }
}

