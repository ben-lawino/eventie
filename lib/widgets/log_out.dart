import 'package:eventie/common/auth/screens/welcome_screen.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/auth/providers/role_provider.dart';
import '../common/providers/profile_provider.dart';

class LogOut extends ConsumerStatefulWidget {
  const LogOut({super.key});

  @override
  ConsumerState<LogOut> createState() => _LogOutState();
}

class _LogOutState extends ConsumerState<LogOut> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                'Log Out',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey[400], thickness: 1, height: 20),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to log out?',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: primaryColor.withOpacity(0.15),
                      text: "Cancel",
                      textColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Button(
                      onPressed: () async {
                        // Reset profile to default (approved) state
                        ref.invalidate(profileProvider);

                        // Clear the role from SharedPreferences and provider
                        await ref.read(roleProvider.notifier).clearRole();

                        if (!context.mounted) return;

                        // Navigate back to welcome screen and clear stack
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WelcomeScreen()),
                          (route) => false,
                        );
                      },
                      text: "Yes, Logout",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

