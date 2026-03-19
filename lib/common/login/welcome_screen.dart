import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              //logo
              Image.asset('assets/icons/applogo.png', scale: 8),

              //appname
              Text(
                "Join Eventie",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 36,
                ),
              ),

              const SizedBox(height: 8),

              /// Subtitle
              Text(
                "Choose how you want use Eventie",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              SizedBox(height: 30),

              //Customer card
              Container(
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
                    /// Icon Circle
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/user_outlined.png',
                          scale: 26,
                          color: primaryColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    /// Text Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Discover and attend amazing events',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    /// Arrow
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              //Organizer card
              Container(
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
                    /// Icon Circle
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/calendar.png',
                          scale: 26,
                          color: primaryColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    /// Text Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organizer',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Create and manage events',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    /// Arrow
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),

              Spacer(),

              /// already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  ),
                  TextButton(
                    onPressed: () {},
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
              Button(
                width: double.infinity,
                onPressed: () {},
                text: 'Continue as Guest',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
