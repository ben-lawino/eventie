import 'package:eventie/common/auth/screens/pending_approval.dart';
import 'package:eventie/common/auth/screens/welcome_screen.dart';
import 'package:eventie/common/providers/profile_provider.dart';
import 'package:eventie/common/services/auth_service.dart';
import 'package:eventie/common/services/database_service.dart';
import 'package:eventie/customer/navigation.dart';
import 'package:eventie/organizer/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // 1. Initial wait for animation/loading
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 2. Load basic local data
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool(_onboardingKey) ?? false;
    await ref.read(roleProvider.notifier).loadRole();

    // 3. Firebase Auth Check & Profile Sync
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final profile = await ref.read(databaseServiceProvider).getProfile(currentUser.uid);
      if (profile != null) {
        ref.read(profileProvider.notifier).update(profile);
      }
    }

    final role = ref.read(roleProvider);
    final profile = ref.read(profileProvider);

    Widget destination;

    if (!hasSeenOnboarding) {
      destination = const OnboardingScreen();
    } else if (currentUser == null) {
      destination = const WelcomeScreen();
    } else if (role == 'organizer') {
      destination = profile.isApproved
          ? const BottomNav()
          : const PendingApprovalScreen();
    } else {
      destination = const NavigationMenu();
    }

    if (!mounted) return;
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