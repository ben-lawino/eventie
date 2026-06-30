import 'package:eventie/common/auth/screens/welcome_screen.dart';
import 'package:eventie/common/services/database_service.dart';
import 'package:eventie/common/providers/profile_provider.dart';
import 'package:eventie/customer/screens/favorite.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/customer/screens/profile.dart';
import 'package:eventie/customer/screens/ticket.dart';
import 'package:eventie/data/categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationMenu extends ConsumerStatefulWidget {
  const NavigationMenu({super.key});

  @override
  ConsumerState<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends ConsumerState<NavigationMenu> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkAndSyncProfile();
  }

  Future<void> _checkAndSyncProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final profile = ref.read(profileProvider);
      if (profile.fullName.isEmpty) {
        final freshProfile = await ref.read(databaseServiceProvider).getProfile(currentUser.uid);
        if (freshProfile != null) {
          ref.read(profileProvider.notifier).update(freshProfile);
        }
      }
    }
  }

  void _onTabTapped(int index) {
    final currentUser = FirebaseAuth.instance.currentUser;

    // Check if user is guest (not logged in) and trying to access restricted tabs
    if (currentUser == null && (index == 1 || index == 2 || index == 3)) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        (route) => false,
      );
      return;
    }

    setState(() => _currentIndex = index);
  }

  final List _screens = [
    HomePage(categories: eventCategories),
    const FavoritePage(),
    const TicketPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _screens[_currentIndex],

      // 💠 Custom Floating Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(26),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_rounded, Icons.home_outlined ,"Home", 0, primaryColor),
            _buildNavItem(Icons.favorite_rounded,Icons.favorite_border_outlined ,"Favorites", 1, primaryColor),
            _buildNavItem(Icons.confirmation_number_rounded, Icons.confirmation_num_outlined,"Tickets", 2, primaryColor),
            _buildNavItem(Icons.person_rounded, Icons.person_outline_rounded,"Profile", 3, primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      IconData outlinedIcon,
      String label, int index,
      Color primaryColor) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? icon : outlinedIcon,
              color: isSelected ? primaryColor : Colors.grey,
              size: 26,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
