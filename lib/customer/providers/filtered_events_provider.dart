import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/dummy_data.dart';
import '../../data/models/event_model.dart';
import 'category_filter_provider.dart';
import 'search_provider.dart';

final filteredEventsProvider = Provider<List<EventModel>>((Ref ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final selectedCategory = ref.watch(categoryProvider);

  return dummyEvents.where((event) {
    final matchesQuery = event.title.toLowerCase().contains(query) ||
        event.description.toLowerCase().contains(query) ||
        event.location.toLowerCase().contains(query);
    
    final matchesCategory = selectedCategory == null || event.category == selectedCategory;

    return matchesQuery && matchesCategory;
  }).toList();
});

final popularEventsProvider = Provider<List<EventModel>>((Ref ref) {
  final allFiltered = ref.watch(filteredEventsProvider);
  return allFiltered.where((e) => e.isFeatured).toList();
});

final exploreEventsProvider = Provider<List<EventModel>>((Ref ref) {
  final allFiltered = ref.watch(filteredEventsProvider);
  return allFiltered;
});
