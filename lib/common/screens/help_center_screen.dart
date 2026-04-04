import 'package:eventie/customer/screens/profile.dart';
import 'package:flutter/material.dart';

import '../../customer/navigation.dart';
import 'mini_screens/contact_us_screen.dart';
import 'mini_screens/faq_screen.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.arrow_back_rounded),
            color: Colors.grey[700],
          ),
          title: Text(
            'Help Center',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            padding: EdgeInsets.only(right: 18, left: 18,bottom: 18),
            indicatorWeight: 3.5,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(child: Text('FAQ')),
              Tab(child: Text('Contact Us')),
            ],
          ),
        ),
        body: TabBarView(children: [FaqScreen(), ContactUsScreen()]),
      ),
    );
    ;
  }
}
