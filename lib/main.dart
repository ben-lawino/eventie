import 'package:eventie/common/login/create_new_password.dart';
import 'package:eventie/common/login/sign_up.dart';
import 'package:eventie/customer/navigation.dart';
import 'package:eventie/customer/screens/mini_screens/explore.dart';
import 'package:eventie/organizer/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common/providers/theme_provider.dart';
import 'common/theme/app_theme.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

// ✅ Change StatelessWidget → ConsumerWidget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventie',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const NavigationMenu(),
    );
  }
}