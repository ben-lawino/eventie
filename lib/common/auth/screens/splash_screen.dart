import 'package:eventie/common/auth/screens/welcome_screen.dart';
import 'package:eventie/customer/navigation.dart';
import 'package:eventie/organizer/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/onboarding.dart';
import '../providers/role_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigate();
  }

  // ── Animations

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();
  }

  // ── Check role and navigate
  final _onboardingKey = 'has_seen_onboarding';
  Future<void> _navigate() async {
    await Future.wait([
      Future.delayed(const Duration(seconds: 2)),
      ref.read(roleProvider.notifier).loadRole(),
    ]);

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool(_onboardingKey) ?? false;
    final role = ref.read(roleProvider);

    Widget destination;

    if (!hasSeenOnboarding) {
      // First time ever — show onboarding
      destination = const OnboardingScreen();
    } else if (role == 'organizer') {
      destination = const BottomNav();
    } else if (role == 'customer') {
      destination = const NavigationMenu();
    } else {
      // Seen onboarding but not signed up yet
      destination = const WelcomeScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ── Build

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ── Logo
                    Image.asset(
                      'assets/icons/applogo.png',
                      scale: 4,
                    ),

                    //const SizedBox(height: 16),

                    // ── App name
                    Text(
                      'Eventie',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ── Tagline
                    Text(
                      'Discover & Create Amazing Events',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[500],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}