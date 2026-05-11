import 'package:flutter/material.dart';

import '../../../data/dummy_notifications.dart';
import '../../../data/models/notification_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<NotificationModel> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(dummyNotifications);
  }

  void _markAllRead() {
    setState(() {
      _notifications = _notifications
          .map((n) => NotificationModel(
        title: n.title,
        description: n.description,
        time: n.time,
        type: n.type,
        isRead: true,
      ))
          .toList();
    });
  }

  List<NotificationModel> get _unread =>
      _notifications.where((n) => !n.isRead).toList();

  List<NotificationModel> get _read =>
      _notifications.where((n) => n.isRead).toList();

  @override
  Widget build(BuildContext context) {
    final hasUnread = _unread.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.grey[700],
        ),
        title: Text(
          'Notifications',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (hasUnread)
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: TextButton(
                onPressed: _markAllRead,
                child: Text(
                  'Mark all read',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmpty()
          : ListView(
        children: [
          if (_unread.isNotEmpty) ...[
            _sectionLabel('Today'),
            ..._unread.map((n) => Dismissible(
              key: Key(n.title),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                setState(() => _notifications.remove(n));
              },
              background: Container(
                color: Colors.red[400],
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                ),
              ),
              child: _NotificationTile(notification: n),
            )),
          ],
          if (_read.isNotEmpty) ...[
            _sectionLabel('Earlier'),
            ..._read.map((n) => Dismissible(
              key: Key(n.title),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                setState(() => _notifications.remove(n));
              },
              background: Container(
                color: Colors.red[400],
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                ),
              ),
              child: _NotificationTile(notification: n),
            )),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 6),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Colors.grey,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_off_outlined,
              size: 56, color: Colors.grey[300]),
          const SizedBox(height: 12),
          Text(
            'No notifications yet',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationTile({required this.notification});

  (Color bg, Color icon, IconData iconData) get _style {
    switch (notification.type) {
      case NotificationType.booking:
        return (
        const Color(0xFFEEEDFE),
        const Color(0xFF534AB7),
        Icons.calendar_today_rounded
        );
      case NotificationType.account:
        return (
        const Color(0xFFEAF3DE),
        const Color(0xFF3B6D11),
        Icons.person_outline_rounded
        );
      case NotificationType.reminder:
        return (
        const Color(0xFFFAEEDA),
        const Color(0xFF854F0B),
        Icons.notifications_outlined
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final (bgColor, iconColor, iconData) = _style;

    return Container(
      color: notification.isRead
          ? Colors.transparent
          : Theme.of(context).colorScheme.primary.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
              ),
              child: Icon(iconData, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'New',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          size: 11, color: Colors.grey[400]),
                      const SizedBox(width: 3),
                      Text(
                        notification.time,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 11,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}