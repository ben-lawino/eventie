import 'package:eventie/common/auth/screens/splash_screen.dart';
import 'package:eventie/common/auth/screens/welcome_screen.dart';
import 'package:eventie/organizer/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common/providers/theme_provider.dart';
import 'common/services/notification_service.dart';
import 'common/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

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
      home: BottomNav(),
    );
  }
}