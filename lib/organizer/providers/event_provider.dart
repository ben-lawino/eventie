import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/event_model.dart';

class EventsNotifier extends StateNotifier<List<EventModel>> {
  EventsNotifier() : super([]);

  void addEvent(EventModel event) {
    state = [...state, event];
  }

  void deleteEvent(String id) {
    state = state.where((e) => e.id != id).toList();
  }

  void updateEvent(EventModel updatedEvent) {
    state = [
      for (final event in state)
        if (event.id == updatedEvent.id) updatedEvent else event
    ];
  }

  List<EventModel> get pendingEvents =>
      state.where((e) => e.status == 'pending').toList();

  List<EventModel> get approvedEvents =>
      state.where((e) => e.status == 'approved').toList();
}

final eventsProvider =
StateNotifierProvider<EventsNotifier, List<EventModel>>((ref) {
  return EventsNotifier();
});