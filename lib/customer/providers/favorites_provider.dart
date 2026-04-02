import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggleFavorite(String eventId) {
    if (state.contains(eventId)) {
      state = state.where((id) => id != eventId).toSet();
    } else {
      state = {...state, eventId};
    }
  }

  bool isFavorite(String eventId) {
    return state.contains(eventId);
  }
}

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, Set<String>>(
      (ref) => FavoritesNotifier(),
);