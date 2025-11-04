import 'package:eventie/customer/screens/favorite.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/customer/screens/profile.dart';
import 'package:eventie/customer/screens/ticket.dart';
import 'package:eventie/data/categories.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _currentIndex = 0;

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
            borderRadius: BorderRadius.only(
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
              _buildNavItem(Icons.home_rounded, "Home", 0, primaryColor),
              _buildNavItem(Icons.favorite_rounded, "Favorites", 1, primaryColor),
              _buildNavItem(Icons.confirmation_number_rounded, "Tickets", 2, primaryColor),
              _buildNavItem(Icons.person_rounded, "Profile", 3, primaryColor),
            ],
          ),
        ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, Color primaryColor) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? primaryColor : Colors.grey.shade600,
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
