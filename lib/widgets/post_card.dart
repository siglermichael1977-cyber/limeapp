import 'package:flutter/material.dart';
import 'package:lime_app/constants/colors.dart';
import 'package:lime_app/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  }) : super(key: key);

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return 'a week ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LimeColors.cardBackground,
        border: Border(
          bottom: BorderSide(
            color: LimeColors.borderLight,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LimeColors.cardGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: LimeColors.textPrimary,
                      ),
                    ),
                    Text(
                      _getTimeAgo(post.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: LimeColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_horiz, color: LimeColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),
          // Content
          Text(
            post.content,
            style: const TextStyle(
              fontSize: 14,
              color: LimeColors.textPrimary,
              height: 1.4,
            ),
          ),
          // Images
          if (post.images.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: LimeColors.background,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: post.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : 8,
                      right: index == post.images.length - 1 ? 0 : 8,
                    ),
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LimeColors.primaryGradient,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 12),
          // Engagement stats
          Row(
            children: [
              Text(
                '${post.likes} likes',
                style: const TextStyle(
                  fontSize: 12,
                  color: LimeColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${post.comments} comments',
                style: const TextStyle(
                  fontSize: 12,
                  color: LimeColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${post.shares} shares',
                style: const TextStyle(
                  fontSize: 12,
                  color: LimeColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionButton(
                icon: post.isLiked ? '❤️' : '🤍',
                label: 'Like',
                onTap: onLike,
              ),
              _ActionButton(
                icon: '💬',
                label: 'Comment',
                onTap: onComment,
              ),
              _ActionButton(
                icon: '🔄',
                label: 'Share',
                onTap: onShare,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: LimeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
