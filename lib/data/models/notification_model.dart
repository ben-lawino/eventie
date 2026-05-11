
enum NotificationType { booking, account, reminder }

class NotificationModel {
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final bool isRead;

  const NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}