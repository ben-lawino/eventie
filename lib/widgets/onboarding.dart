import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/auth/screens/welcome_screen.dart';
import 'onboarding_page.dart';

const String _onboardingKey = 'has_seen_onboarding';

const _images = [
  'assets/images/onboarding_one.jpg',
  'assets/images/onboarding_two.jpg',
  'assets/images/onboarding_three.jpg',
];

const _pages = [
  (
  title: 'Find',
  boldWord: 'Events',
  titleEnd: 'That Excite You',
  description: 'Concerts, parties, and cool spots all happening around you.',
  image: 'assets/images/onboarding_one.jpg',
  ),
  (
  title: '',
  boldWord: 'Vendors',
  titleEnd: 'That Bring The Vibe',
  description: 'Find top photographers and vendors near you. Book fast and stress-free.',
  image: 'assets/images/onboarding_two.jpg',
  ),
  (
  title: 'Manage',
  boldWord: 'Payments',
  titleEnd: 'All On Your Phone',
  description: 'Secure bookings and payments in just a few taps.',
  image: 'assets/images/onboarding_three.jpg',
  ),
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow
                  if (_currentPage > 0)
                    GestureDetector(
                      onTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_rounded, size: 20),
                      ),
                    )
                  else
                    const SizedBox(width: 36),

                  // Skip
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) =>
                    setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnboardingPage(
                    image: page.image,
                    title: page.title,
                    boldWord: page.boldWord,
                    titleEnd: page.titleEnd,
                    description: page.description,
                    allImages: _images,
                  );
                },
              ),
            ),

            // Bottom section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 16 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? primaryColor
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Button
                  Button(
                    height: 50,
                    onPressed: _nextPage,
                    text: isLastPage ? 'Get Started' : 'Continue',
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