import 'package:eventie/customer/screens/favorite.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/customer/screens/ticket.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _currentIndex = 0;

  final List _screens = [
   HomePage(),
    FavoritePage(),
    TicketPage(),
    FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: Icon(Iconsax.home,),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.heart),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.ticket),
            label: 'Ticket'
          ),
          NavigationDestination(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ]
      ),
      body: _screens[_currentIndex],
    );
  }
}
