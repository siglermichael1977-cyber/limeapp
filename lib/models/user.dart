class User {
  final String id;
  final String name;
  final String username;
  final String avatar;
  final String bio;
  final int followers;
  final int following;
  final int posts;
  final bool isFollowing;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    this.bio = '',
    this.followers = 0,
    this.following = 0,
    this.posts = 0,
    this.isFollowing = false,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'] ?? '',
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      posts: json['posts'] ?? 0,
      isFollowing: json['isFollowing'] ?? false,
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'avatar': avatar,
      'bio': bio,
      'followers': followers,
      'following': following,
      'posts': posts,
      'isFollowing': isFollowing,
      'isVerified': isVerified,
    };
  }
}
