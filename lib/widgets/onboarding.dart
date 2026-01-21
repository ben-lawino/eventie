import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // sliding pages
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                children: const [
                  OnboardingPage(
                    image: 'assets/images/onboardingone.png',
                    title: 'All your events,',
                    subtitle: 'Right in your hands.',
                    description:
                        'Concerts, parties, and cool spots all happening around you.',
                  ),
                  OnboardingPage(
                    image: 'assets/images/onboardingtwo.png',
                    title: 'Easy payments.',
                    subtitle: 'Fast ticketing.',
                    description: 'Find top photographers and vendors near you.',
                  ),
                  OnboardingPage(
                    image: 'assets/images/onboardingthree.png',
                    title: 'manage your event finances,',
                    subtitle: 'All on your phone',
                    description:
                        'Secure bookings and payments in just a few taps.',
                  ),
                ],
              ),
            ),
        
            // Bottom section
            Container(
              height: height * 0.25,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage == index ? 16 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
        
                  // Button
                  Button(
                    height: 50,
                    onPressed: () {},
                    text: 'Get Started',
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
