import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(<String>{});

  //Toggle favorite (add/remove)
  void toggleFavorite(String eventId) {
    final newState = Set<String>.from(state);

    if (newState.contains(eventId)) {
      newState.remove(eventId);
    } else {
      newState.add(eventId);
    }

    state = newState;
  }

  // Remove explicitly
  void remove(String eventId) {
    final newState = Set<String>.from(state);
    newState.remove(eventId);
    state = newState;
  }

  // Add explicitly
  void add(String eventId) {
    state = {...state, eventId};
  }

  //Check if event is favorite
  bool isFavorite(String eventId) {
    return state.contains(eventId);
  }
}

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, Set<String>>(
      (ref) => FavoritesNotifier(),
);