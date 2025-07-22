import 'package:eventie/customer/screens/favorite.dart';
import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/customer/screens/ticket.dart';
import 'package:flutter/material.dart';


class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _currentIndex = 0;

  final List _screens = [
    HomePage(categories: [],),
    FavoritePage(),
    TicketPage(),
    FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        indicatorColor: Colors.transparent,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: Image.asset('assets/icons/home_outlined.png',height: 24,width: 24,color: Color(0xff757575)),
            selectedIcon:Image.asset('assets/icons/home_filled.png',height: 24,width: 24,color :Theme.of(context).colorScheme.primary,),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/heart_outlined.png',height: 24,width: 24,color: Color(0xff757575)),
            selectedIcon:Image.asset('assets/icons/heart_filled.png',height: 24,width: 24,color :Theme.of(context).colorScheme.primary,),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/ticket_outlined.png',height: 24,width: 24,color: Color(0xff757575)),
            selectedIcon:Image.asset('assets/icons/ticket_filled.png',height: 24,width: 24,color :Theme.of(context).colorScheme.primary,),
            label: 'Tickets',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/user_outlined.png',height: 24,width: 24,color: Color(0xff757575)),
            selectedIcon:Image.asset('assets/icons/user_filled.png',height: 24,width: 24,color :Theme.of(context).colorScheme.primary,),
            label: 'Profile',
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
