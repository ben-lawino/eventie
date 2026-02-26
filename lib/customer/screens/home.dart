import 'package:eventie/customer/screens/mini_screens/explore.dart';
import 'package:eventie/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../data/models/category_model.dart';
import '../../widgets/featured_list.dart';
import '../../widgets/small_event_list.dart';

class HomePage extends StatelessWidget {
  final List<CategoryModel> categories;

  const HomePage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: const AssetImage('assets/images/hacker.png'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning',
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: Colors.grey),
            ),
            Text(
              'Ben lawin',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/notification.png',
                width: 25,
                height: 25,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              //Searchbar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
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
                      hintStyle: Theme.of(context).textTheme.labelMedium!
                          .copyWith(color: Colors.grey[500], fontSize: 14),
                      prefixIcon: Image.asset(
                        'assets/icons/search.png',
                        scale: 25,
                        color: Colors.grey[500],
                      ),
                      suffixIcon: Image.asset(
                        'assets/icons/filter.png',
                        scale: 25,
                        color: Theme.of(context).colorScheme.primary,
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

              const SizedBox(height: 28),

              //just announced
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              EventsList(dummyEvents: dummyEvents),
              const SizedBox(height: 28),

              //Explore
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore Events',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ExplorePage(categories: categories),
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return FilterButton(
                      label: category.name,
                      icon: category.icon,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                ),
              ),
              SmallEventList(dummyEvents: dummyEvents),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
