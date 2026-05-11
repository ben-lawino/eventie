
import 'models/notification_model.dart';

final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    title: 'Booking confirmed',
    description:
    'You\'ve successfully booked Art Workshop. It starts Sun, Dec 22 at 13:00 PM. Don\'t forget to set your reminder!',
    time: '20 Dec 2025 · 20:49',
    type: NotificationType.booking,
    isRead: false,
  ),
  NotificationModel(
    title: 'Account setup complete',
    description: 'Your account is ready. Start exploring events near you!',
    time: '20 Dec 2025 · 18:30',
    type: NotificationType.account,
    isRead: false,
  ),
  NotificationModel(
    title: 'Event reminder',
    description: 'Jazz Night at Nairobi Gallery starts in 2 hours. Get ready!',
    time: '18 Dec 2025 · 10:00',
    type: NotificationType.reminder,
    isRead: true,
  ),
];
