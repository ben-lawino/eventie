class DashboardData {
  final int totalEvents;
  final int ticketsSold;
  final int approved;
  final int completed;
  final double revenue;
  final List<String> activities;

  DashboardData({
    required this.totalEvents,
    required this.ticketsSold,
    required this.approved,
    required this.completed,
    required this.revenue,
    required this.activities,
  });
}