import 'package:flutter/material.dart';
import 'package:lime_app/constants/colors.dart';
import 'package:lime_app/models/message.dart';
import 'package:lime_app/widgets/message_item.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late List<Message> conversations;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  void _loadConversations() {
    conversations = [
      Message(
        id: '1',
        conversationId: 'conv1',
        senderId: 'user1',
        senderName: 'Alex Rivera',
        senderAvatar: 'avatar1',
        content: 'Hey! How are you doing?',
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
        isRead: false,
        unreadCount: 3,
      ),
      Message(
        id: '2',
        conversationId: 'conv2',
        senderId: 'user2',
        senderName: 'Caribbean Crew',
        senderAvatar: 'avatar2',
        content: 'Thanks for coming to the event yesterday!',
        createdAt: DateTime.now().subtract(const Duration(minutes: 14)),
        isRead: false,
        unreadCount: 1,
      ),
      Message(
        id: '3',
        conversationId: 'conv3',
        senderId: 'user3',
        senderName: 'Jazz Events',
        senderAvatar: 'avatar3',
        content: 'New jazz night coming up next week 🎷',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
        isRead: true,
        unreadCount: 0,
      ),
      Message(
        id: '4',
        conversationId: 'conv4',
        senderId: 'user4',
        senderName: 'Island Adventures',
        senderAvatar: 'avatar4',
        content: 'That beach was amazing!',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: true,
        unreadCount: 0,
      ),
      Message(
        id: '5',
        conversationId: 'conv5',
        senderId: 'user5',
        senderName: 'Miguel Santos',
        senderAvatar: 'avatar5',
        content: 'Can\'t wait for the next meetup',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
        unreadCount: 0,
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LimeColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Messages',
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
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New message feature coming soon!')),
                );
              },
              child: const Icon(
                Icons.edit,
                color: LimeColors.accentGreen,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: LimeColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: LimeColors.borderLight,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  hintStyle: const TextStyle(color: LimeColors.textTertiary),
                  prefixIcon: const Icon(Icons.search, color: LimeColors.textSecondary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          // Messages list
          Expanded(
            child: conversations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '💬',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No messages yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: LimeColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      return MessageItem(
                        message: conversations[index],
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Open chat with ${conversations[index].senderName}',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
