import 'package:eventie/common/auth/screens/signin.dart';
import 'package:eventie/customer/navigation.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/role_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;

    void onRoleSelected(String role) {
      ref.read(roleProvider.notifier).selectRole(role);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // ── Logo
              Image.asset('assets/icons/applogo.png', scale: 6),

              // ── App name
              Text(
                "Join Eventie",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 34,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Choose how you want to use Eventie",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 30),

              // Customer card
              _RoleCard(
                icon: 'assets/icons/user_outlined.png',
                title: 'Customer',
                subtitle: 'Discover and attend amazing events',
                onTap: () => onRoleSelected('customer'),
              ),

              const SizedBox(height: 20),

              // Organizer card
              _RoleCard(
                icon: 'assets/icons/calendar.png',
                title: 'Organizer',
                subtitle: 'Create and manage events',
                onTap: () => onRoleSelected('organizer'),
              ),

              const Spacer(),

              // ── Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      // Don't touch role — let SignInScreen read from
                      // SharedPreferences after successful sign in
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SignInScreen()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Guest
              Button(
                width: double.infinity,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NavigationMenu()),
                  );
                },
                text: 'Continue as Guest',
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// role card

class _RoleCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(icon, scale: 26, color: primaryColor),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}