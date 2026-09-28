import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lime_app/constants/colors.dart';
import 'package:lime_app/models/post.dart';
import 'package:lime_app/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> posts = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      final rows = await Supabase.instance.client
          .from('posts')
          .select(
              'id, body, image_url, island, created_at, author_id, profiles!posts_author_id_fkey(display_name, username, avatar_url)')
          .order('created_at', ascending: false)
          .limit(50);

      final loaded = (rows as List).map((r) {
        final rawProfile = r['profiles'];
        final Map profile = rawProfile is List
            ? (rawProfile.isEmpty ? const {} : rawProfile.first as Map)
            : (rawProfile is Map ? rawProfile : const {});
        final image = r['image_url'] as String?;
        return Post(
          id: r['id']?.toString() ?? '',
          userId: r['author_id']?.toString() ?? '',
          userName: (profile['display_name'] ?? profile['username'] ?? 'Someone')
              .toString(),
          userAvatar: (profile['avatar_url'] ?? '').toString(),
          content: (r['body'] ?? '').toString(),
          images:
              (image == null || image.isEmpty) ? const <String>[] : <String>[image],
          createdAt:
              DateTime.tryParse(r['created_at']?.toString() ?? '') ?? DateTime.now(),
          location: (r['island'] ?? '').toString(),
        );
      }).toList();

      if (!mounted) return;
      setState(() {
        posts = loaded;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Could not load posts.\n' + _error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
    if (posts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'No posts yet. Be the first to share something.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadPosts,
      child: ListView.builder(
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
