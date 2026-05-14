import 'package:flutter_riverpod/legacy.dart';

import '../../data/models/dashboard_data.dart';

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
    // TODO: replace with API call
    state = DashboardData(
      totalEvents: 13,
      ticketsSold: 1667,
      approved: 5,
      completed: 1,
      revenue: 230000,
      activities: [
        '20 new tickets sold',
        'Events approved',
        'Payout of Ksh 5,000 processed',
      ],
    );
  }
}

final dashboardProvider =
StateNotifierProvider<DashboardNotifier, DashboardData>((ref) {
  return DashboardNotifier();
});