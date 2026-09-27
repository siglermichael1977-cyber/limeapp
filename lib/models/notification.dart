enum NotificationType {
  like,
  comment,
  follow,
  mention,
  message,
  share,
}

class Notification {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final NotificationType type;
  final String content;
  final DateTime createdAt;
  final bool isRead;
  final String? relatedPostId;

  Notification({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.type,
    required this.content,
    required this.createdAt,
    this.isRead = false,
    this.relatedPostId,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'] ?? '',
      type: NotificationType.values[json['type'] ?? 0],
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      isRead: json['isRead'] ?? false,
      relatedPostId: json['relatedPostId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'type': type.index,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      'relatedPostId': relatedPostId,
    };
  }

  String get typeEmoji {
    switch (type) {
      case NotificationType.like:
        return '❤️';
      case NotificationType.comment:
        return '💬';
      case NotificationType.follow:
        return '👤';
      case NotificationType.mention:
        return '🎉';
      case NotificationType.message:
        return '✉️';
      case NotificationType.share:
        return '🔄';
    }
  }
}
