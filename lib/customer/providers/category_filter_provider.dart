import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<String?> {
  CategoryNotifier() : super(null);

  void selectCategory(String? category) {
    if (state == category) {
      state = null; // toggle off
    } else {
      state = category;
    }
  }
}

final categoryProvider =
StateNotifierProvider<CategoryNotifier, String?>(
      (ref) => CategoryNotifier(),
);