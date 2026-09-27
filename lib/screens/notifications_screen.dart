import 'package:flutter/material.dart';
import 'package:lime_app/constants/colors.dart';
import 'package:lime_app/models/notification.dart';
import 'package:lime_app/widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<Notification> notifications;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    notifications = [
      Notification(
        id: '1',
        userId: 'user1',
        userName: 'Alex Rivera',
        userAvatar: 'avatar1',
        type: NotificationType.like,
        content: 'liked your post',
        createdAt: DateTime.now(),
        isRead: false,
      ),
      Notification(
        id: '2',
        userId: 'user2',
        userName: 'Caribbean Crew',
        userAvatar: 'avatar2',
        type: NotificationType.comment,
        content: 'commented on your post',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),
      Notification(
        id: '3',
        userId: 'user3',
        userName: 'Jazz Events',
        userAvatar: 'avatar3',
        type: NotificationType.follow,
        content: 'started following you',
        createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
        isRead: true,
      ),
      Notification(
        id: '4',
        userId: 'user4',
        userName: 'Miguel Santos',
        userAvatar: 'avatar4',
        type: NotificationType.like,
        content: 'liked your post',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true,
      ),
      Notification(
        id: '5',
        userId: 'user5',
        userName: 'Island Adventures',
        userAvatar: 'avatar5',
        type: NotificationType.follow,
        content: 'started following you',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: true,
      ),
      Notification(
        id: '6',
        userId: 'user6',
        userName: 'Festival Team',
        userAvatar: 'avatar6',
        type: NotificationType.mention,
        content: 'mentioned you in a comment',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LimeColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: LimeColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mark all as read')),
                  );
                },
                child: const Text(
                  'Mark all as read',
                  style: TextStyle(
                    color: LimeColors.accentGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🔔',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: LimeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationItem(
                  notification: notifications[index],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${notifications[index].userName} - ${notifications[index].content}',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
