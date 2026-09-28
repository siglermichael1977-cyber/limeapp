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
    posts = [];
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
