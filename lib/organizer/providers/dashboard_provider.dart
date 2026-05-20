import 'package:flutter_riverpod/legacy.dart';
import '../../data/dummy_data.dart';
import '../../data/models/dashboard_data.dart';
import '../../data/models/event_model.dart';

class DashboardNotifier extends StateNotifier<DashboardData> {
  DashboardNotifier()
      : super(
    DashboardData(
      totalEvents: 0,
      ticketsSold: 0,
      approved: 0,
      completed: 0,
      revenue: 0,
      activities: [],
    ),
  );

  void loadDashboard() {
    final events = dummyEvents;

    // Total events
    final totalEvents = events.length;

    // Approved events
    final approved = events
        .where((e) => e.status == EventStatus.approved)
        .length;

    // Completed events (past events)
    final completed = events
        .where((e) => e.eventDate.isBefore(DateTime.now()))
        .length;

    // Tickets sold
    int ticketsSold = 0;

    // Revenue
    double revenue = 0;

    for (final event in events) {
      for (final ticket in event.tickets) {
        ticketsSold += ticket.sold;
        revenue += ticket.price * ticket.sold;
      }
    }

    state = DashboardData(
      totalEvents: totalEvents,
      ticketsSold: ticketsSold,
      approved: approved,
      completed: completed,
      revenue: revenue,
      activities: [
        '$ticketsSold tickets sold across all events',
        '$approved events approved',
        'Revenue generated: Ksh ${revenue.toStringAsFixed(0)}',
      ],
    );
  }
}

final dashboardProvider =
StateNotifierProvider<DashboardNotifier, DashboardData>((ref) {
  return DashboardNotifier();
});