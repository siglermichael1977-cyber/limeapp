class Post {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final List<String> images;
  final int likes;
  final int comments;
  final int shares;
  final DateTime createdAt;
  final bool isLiked;
  final String location;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    this.images = const [],
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    required this.createdAt,
    this.isLiked = false,
    this.location = '',
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'] ?? '',
      content: json['content'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      shares: json['shares'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      isLiked: json['isLiked'] ?? false,
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'content': content,
      'images': images,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'createdAt': createdAt.toIso8601String(),
      'isLiked': isLiked,
      'location': location,
    };
  }
}
