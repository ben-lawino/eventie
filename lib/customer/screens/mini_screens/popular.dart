import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/data/categories.dart';
import 'package:eventie/data/dummy_data.dart';
import 'package:eventie/widgets/small_event_list.dart';
import 'package:flutter/material.dart';

class PopularEventsPAge extends StatelessWidget {
  const PopularEventsPAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(categories: eventCategories),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.grey[700],
        ),
        title: Text(
          'Popular',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/search.png',
              scale: 25,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          SmallEventList(dummyEvents: dummyEvents),
        ],
      ),
    );
  }
}
