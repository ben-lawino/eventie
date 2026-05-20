import 'package:eventie/organizer/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../customer/screens/mini_screens/notification.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    Future.microtask(() {
      ref.read(dashboardProvider.notifier).loadDashboard();
      _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = ref.watch(dashboardProvider);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FA),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: CustomScrollView(
          slivers: [
            // Hero Header
            SliverToBoxAdapter(
              child: _HeroHeader(
                primaryColor: primaryColor,
                revenue: 'Ksh ${_formatCurrency(dashboard.revenue)}',
                onNotificationTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationPage(),
                  ),
                ),
              ),
            ),

            // Stat Cards Grid
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate([
                  _StatCard(
                    title: 'Total Events',
                    value: dashboard.totalEvents.toString(),
                    trend: '+2 this week',
                    icon: Icons.calendar_month_rounded,
                    accentColor: const Color(0xFF7F77DD),
                    bgColor: const Color(0xFFEEEDFE),
                  ),
                  _StatCard(
                    title: 'Tickets Sold',
                    value: _formatNumber(dashboard.ticketsSold),
                    trend: '↑ 8.3%',
                    icon: Icons.confirmation_number_rounded,
                    accentColor: const Color(0xFF1D9E75),
                    bgColor: const Color(0xFFE1F5EE),
                  ),
                  _StatCard(
                    title: 'Approved',
                    value: dashboard.approved.toString(),
                    trend: 'of ${dashboard.totalEvents} events',
                    icon: Icons.check_circle_rounded,
                    accentColor: const Color(0xFF378ADD),
                    bgColor: const Color(0xFFE6F1FB),
                  ),
                  _StatCard(
                    title: 'Completed',
                    value: dashboard.completed.toString(),
                    trend: '4 upcoming',
                    icon: Icons.emoji_events_rounded,
                    accentColor: const Color(0xFFBA7517),
                    bgColor: const Color(0xFFFAEEDA),
                  ),
                ]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.35,
                ),
              ),
            ),

            // Ticket Goal Progress
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: _ProgressCard(
                  sold: dashboard.ticketsSold,
                  goal: 2000,
                  accentColor: primaryColor,
                ),
              ),
            ),

            //Recent Activity
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Activity',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: _ActivityCard(
                  items: dashboard.activities
                      .map((a) => _ActivityItem.fromString(a))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}k' : n.toString();

  String _formatCurrency(num n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) {
      // e.g. 230000 → "230,000"
      final s = n.toInt().toString();
      final buf = StringBuffer();
      for (var i = 0; i < s.length; i++) {
        if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
        buf.write(s[i]);
      }
      return buf.toString();
    }
    return n.toString();
  }
}

// Hero Header

class _HeroHeader extends StatelessWidget {
  final Color primaryColor;
  final String revenue;
  final VoidCallback onNotificationTap;

  const _HeroHeader({
    required this.primaryColor,
    required this.revenue,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.95),
            primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white.withOpacity(0.25),
                backgroundImage: const AssetImage('assets/images/hacker.png'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Good Morning',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Ben lawin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Revenue pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Revenue',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      revenue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '↑ 14% this month',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Stat Card

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final IconData icon;
  final Color accentColor;
  final Color bgColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.icon,
    required this.accentColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          left: BorderSide(color: accentColor, width: 4),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF888888),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 11,
                  color: accentColor.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Progress Card

class _ProgressCard extends StatelessWidget {
  final int sold;
  final int goal;
  final Color accentColor;

  const _ProgressCard({
    required this.sold,
    required this.goal,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (sold / goal).clamp(0.0, 1.0);
    final pct = (progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ticket Goal Progress',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF888888),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$sold / $goal',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: accentColor.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$pct% of monthly goal reached',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }
}

//  Activity Card

class _ActivityItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const _ActivityItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });


  factory _ActivityItem.fromString(String activity) {
    final lower = activity.toLowerCase();
    if (lower.contains('ticket') || lower.contains('sold')) {
      return _ActivityItem(
        title: activity,
        subtitle: 'Just now',
        icon: Icons.confirmation_number_rounded,
        iconColor: const Color(0xFF1D9E75),
        iconBg: const Color(0xFFE1F5EE),
      );
    } else if (lower.contains('approved') || lower.contains('approval')) {
      return _ActivityItem(
        title: activity,
        subtitle: 'Recently',
        icon: Icons.check_circle_rounded,
        iconColor: const Color(0xFF185FA5),
        iconBg: const Color(0xFFE6F1FB),
      );
    } else if (lower.contains('payout') || lower.contains('payment')) {
      return _ActivityItem(
        title: activity,
        subtitle: 'Processed',
        icon: Icons.credit_card_rounded,
        iconColor: const Color(0xFFBA7517),
        iconBg: const Color(0xFFFAEEDA),
      );
    } else {
      return _ActivityItem(
        title: activity,
        subtitle: 'Recently',
        icon: Icons.info_outline_rounded,
        iconColor: const Color(0xFF534AB7),
        iconBg: const Color(0xFFEEEDFE),
      );
    }
  }
}

class _ActivityCard extends StatelessWidget {
  final List<_ActivityItem> items;

  const _ActivityCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          return Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: item.iconBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item.icon, color: item.iconColor, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.subtitle,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFAAAAAA),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (i < items.length - 1)
                const Divider(height: 0.5, indent: 64, endIndent: 14),
            ],
          );
        }).toList(),
      ),
    );
  }
}