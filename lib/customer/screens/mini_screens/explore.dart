import 'package:eventie/customer/screens/home.dart';
import 'package:eventie/data/categories.dart';
import 'package:eventie/data/dummy_data.dart';
import 'package:eventie/data/models/category_model.dart';
import 'package:eventie/widgets/filter_button.dart' show FilterButton;
import 'package:eventie/widgets/small_event_list.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final List<CategoryModel> categories;
  const ExplorePage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              hintText: 'What events are you looking for?',
              hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              prefixIcon: Image.asset(
                'assets/icons/search.png',
                scale: 25,
                color: Colors.grey[500],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return FilterButton(label: category.name, icon: category.icon);
              },
              separatorBuilder: (_, __) => const SizedBox(width: 12),
            ),
          ),
          SmallEventList(dummyEvents: dummyEvents),
        ],
      ),
    );
  }
}
