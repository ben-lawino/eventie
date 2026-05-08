import 'package:eventie/customer/screens/profile.dart';
import 'package:eventie/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_app_bar.dart';
import '../providers/notifications_settings_provider.dart';


class NotificationSettingScreen extends ConsumerWidget {
  const NotificationSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(notificationSettingsProvider);
    final notifier =
    ref.read(notificationSettingsProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notification Settings',
        backDestination: ProfilePage(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingTile(
                title: "Enable Notifications",
                value: settings.enableNotifications,
                onChanged: notifier.toggleEnableNotifications,
              ),

              SettingTile(
                title: "Ticket Updates",
                value: settings.ticketUpdates,
                onChanged: settings.enableNotifications
                    ? notifier.toggleTicketUpdates
                    : null,
              ),

              SettingTile(
                title: "Event Recommendations",
                value: settings.eventRecommendations,
                onChanged: settings.enableNotifications
                    ? notifier.toggleEventRecommendations
                    : null,
              ),

              SettingTile(
                title: "Promotions",
                value: settings.promotions,
                onChanged: settings.enableNotifications
                    ? notifier.togglePromotions
                    : null,
              ),

              SettingTile(
                title: "App Updates",
                value: settings.appUpdates,
                onChanged: settings.enableNotifications
                    ? notifier.toggleAppUpdates
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}