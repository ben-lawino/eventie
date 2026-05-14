import 'package:riverpod/legacy.dart';
import '../services/notification_service.dart';

class NotificationSettings {
  final bool enableNotifications;
  final bool ticketUpdates;
  final bool eventRecommendations;
  final bool promotions;
  final bool appUpdates;

  const NotificationSettings({
    required this.enableNotifications,
    required this.ticketUpdates,
    required this.eventRecommendations,
    required this.promotions,
    required this.appUpdates,
  });

  NotificationSettings copyWith({
    bool? enableNotifications,
    bool? ticketUpdates,
    bool? eventRecommendations,
    bool? promotions,
    bool? appUpdates,
  }) {
    return NotificationSettings(
      enableNotifications:
      enableNotifications ?? this.enableNotifications,
      ticketUpdates: ticketUpdates ?? this.ticketUpdates,
      eventRecommendations:
      eventRecommendations ?? this.eventRecommendations,
      promotions: promotions ?? this.promotions,
      appUpdates: appUpdates ?? this.appUpdates,
    );
  }
}

class NotificationSettingsNotifier
    extends StateNotifier<NotificationSettings> {
  NotificationSettingsNotifier()
      : super(
    const NotificationSettings(
      enableNotifications: false,
      ticketUpdates: false,
      eventRecommendations: false,
      promotions: false,
      appUpdates: false,
    ),
  );

  void toggleEnableNotifications(bool value) async {
    state = state.copyWith(enableNotifications: value);

    if (value) {
      await NotificationService.showNotification(
        title: "Notifications Enabled",
        body: "You will now receive event updates.",
      );
    }
  }
  void toggleTicketUpdates(bool value) {
    state = state.copyWith(ticketUpdates: value);
  }

  void toggleEventRecommendations(bool value) {
    state = state.copyWith(eventRecommendations: value);
  }

  void togglePromotions(bool value) {
    state = state.copyWith(promotions: value);
  }

  void toggleAppUpdates(bool value) {
    state = state.copyWith(appUpdates: value);
  }
}

final notificationSettingsProvider = StateNotifierProvider<
    NotificationSettingsNotifier,
    NotificationSettings>((ref) {
  return NotificationSettingsNotifier();
});