import 'package:flutter/material.dart';
import 'package:lime_app/constants/colors.dart';
import 'package:lime_app/models/post.dart';
import 'package:lime_app/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late List<Post> posts;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    posts = [
      Post(
        id: '1',
        userId: 'user1',
        userName: 'Alex Rivera',
        userAvatar: 'avatar1',
        content: 'Just finished an amazing hike on the island! 🏔️ The views were incredible.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likes: 342,
        comments: 28,
        shares: 15,
        isLiked: false,
      ),
      Post(
        id: '2',
        userId: 'user2',
        userName: 'Caribbean Crew',
        userAvatar: 'avatar2',
        content: 'New music production featuring local artists dropping tomorrow! Stay tuned 🎵',
        createdAt: DateTime.now().subtract(const Duration(minutes: 32)),
        likes: 856,
        comments: 67,
        shares: 234,
        isLiked: true,
      ),
      Post(
        id: '3',
        userId: 'user3',
        userName: 'Jazz Events',
        userAvatar: 'avatar3',
        content: 'Tonight\'s jazz night was unforgettable! Thanks to everyone who came out! 🎷',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        likes: 523,
        comments: 42,
        shares: 89,
        isLiked: false,
      ),
      Post(
        id: '4',
        userId: 'user4',
        userName: 'Island Adventures',
        userAvatar: 'avatar4',
        content: 'Exploring hidden beaches is my favorite pastime. Where should I go next? 🏖️',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        likes: 234,
        comments: 56,
        shares: 12,
        isLiked: false,
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
        title: Container(
          height: 48,
          decoration: BoxDecoration(
            gradient: LimeColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: LimeColors.primaryShadow,
          ),
          child: Center(
            child: Text(
              'Lime',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(
            post: posts[index],
            onLike: () {
              setState(() {
                posts[index] = Post(
                  id: posts[index].id,
                  userId: posts[index].userId,
                  userName: posts[index].userName,
                  userAvatar: posts[index].userAvatar,
                  content: posts[index].content,
                  images: posts[index].images,
                  likes: posts[index].isLiked
                      ? posts[index].likes - 1
                      : posts[index].likes + 1,
                  comments: posts[index].comments,
                  shares: posts[index].shares,
                  createdAt: posts[index].createdAt,
                  isLiked: !posts[index].isLiked,
                  location: posts[index].location,
                );
              });
            },
            onComment: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Comment feature coming soon!')),
              );
            },
            onShare: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon!')),
              );
            },
          );
        },
      ),
    );
  }
}
