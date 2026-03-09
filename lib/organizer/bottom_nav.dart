import 'package:eventie/customer/screens/favorite.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/customer/screens/profile.dart';
import 'package:eventie/customer/screens/ticket.dart';
import 'package:eventie/data/categories.dart';
import 'package:eventie/organizer/screens/dashboard.dart';
import 'package:eventie/organizer/screens/events.dart';
import 'package:eventie/organizer/screens/profile.dart';
import 'package:eventie/organizer/screens/scanner.dart';
import 'package:eventie/organizer/screens/wallet.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final List _screens = [
    DashboardScreen(),
    ScannerScreen(),
    EventsScreen(),
    WalletScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _screens[_currentIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Container(
        height: 100,
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
            _buildNavItem(Icons.home_rounded, Icons.home_outlined ,"Dashboard", 0, primaryColor),
            _buildNavItem(Icons.scanner_rounded,Icons.scanner_outlined ,"Scan", 1, primaryColor),
            _buildNavItem(Icons.event_rounded, Icons.event_outlined,"Events", 2, primaryColor),
            _buildNavItem(Icons.wallet_rounded, Icons.wallet_outlined,"Wallet", 3, primaryColor),
            _buildNavItem(Icons.person_rounded, Icons.person_outline_rounded,"Profile", 4, primaryColor),
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
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              size: 20,
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