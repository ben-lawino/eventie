import 'package:eventie/common/auth/providers/role_provider.dart';
import 'package:eventie/common/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventie/widgets/button.dart';
import '../screens/welcome_screen.dart';
import '../../screens/admin_dashboard.dart';

class PendingApprovalScreen extends ConsumerWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onLongPress: () {
                  // Secret shortcut for demo purposes to access Admin Dashboard
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminDashboard()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.hourglass_empty_rounded,
                    size: 80,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Approval Pending',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your organizer account has been created and is currently awaiting approval from our super admin.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We will send an email to your registered address once your account is ready to use.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              Button(
                onPressed: () async {
                  // Reset profile and role so they can try logging in as someone else
                  ref.invalidate(profileProvider);
                  await ref.read(roleProvider.notifier).clearRole();

                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                    (route) => false,
                  );
                },
                text: 'Back to Welcome',
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

