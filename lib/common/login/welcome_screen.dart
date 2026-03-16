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
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const Spacer(),

              /// Illustration
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: Image.asset("assets/icons/applogo.png"),
              ),

              const SizedBox(height: 20),

              /// App name
              Text(
                "Eventie",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 40

                ),
              ),

              const SizedBox(height: 8),

              /// Subtitle
              Text(
                "An Event Sharing App\nFor Everyone",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              Spacer(),

              /// Create Account Button
              Button(
                width: double.infinity,
                onPressed: () {},
                text: 'Create Account',
              ),

              const SizedBox(height: 16),

              /// Already have account button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xff4F63D2), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Already have an account",
                    style: TextStyle(fontSize: 16, color: Color(0xff4F63D2)),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Continue as guest
              TextButton(
                onPressed: () {},
                child: Text(
                  'Continue as a guest?',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ),
             SizedBox(
               height: 10,
             )
            ],
          ),
        ),
      ),
    );
  }
}
