import 'package:eventie/data/dummy_data.dart';
import 'package:eventie/data/models/category_model.dart';
import 'package:eventie/widgets/filter_button.dart';
import 'package:eventie/widgets/small_event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/category_filter_provider.dart';
import '../../providers/search_provider.dart';

class ExplorePage extends ConsumerWidget {
  final List<CategoryModel> categories;

  const ExplorePage({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);

    // filter logic
    final filteredEvents = selectedCategory == null
        ? dummyEvents
        : dummyEvents
            .where((event) => event.category == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Consumer(
          builder: (context, ref, _) {
            final isSearching = ref.watch(searchOpenProvider);

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isSearching
                  ? TextField(
                key: const ValueKey("searchField"),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  border: InputBorder.none,
                ),
              )
                  : Text(
                "Explore Events",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                key: const ValueKey("title"),
              ),
            );
          },
        ),

        actions: [
          Consumer(
            builder: (context, ref, _) {
              final isSearching = ref.watch(searchOpenProvider);

              return IconButton(
                icon: Icon(isSearching ? Icons.close : Icons.search),
                onPressed: () {
                  ref.read(searchOpenProvider.notifier).state =
                  !isSearching;
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),

          // category list
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return FilterButton(
                    label: "All",
                    icon: Icons.apps,
                    isSelected: selectedCategory == null,
                    onTap: () {
                      ref.read(categoryProvider.notifier).selectCategory(null);
                    },
                  );
                }

                final category = categories[index - 1];

                return FilterButton(
                  label: category.name,
                  icon: category.icon,
                  isSelected: selectedCategory == category.name,
                  onTap: () {
                    ref
                        .read(categoryProvider.notifier)
                        .selectCategory(category.name);
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 12),
            ),
          ),

          const SizedBox(height: 10),

          //  results header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              selectedCategory == null
                  ? "All Events"
                  : "$selectedCategory Events",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),

          const SizedBox(height: 10),

          // event list
          Expanded(
            child: filteredEvents.isEmpty
                ? const Center(
                    child: Text("No events found 😕"),
                  )
                : SmallEventList(dummyEvents: filteredEvents),
          ),
        ],
      ),
    );
  }
}
