import 'package:flutter/material.dart';
import 'package:lime_app/constants/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, String>> trendingTags = [
    {'tag': '#CaribeanVibes', 'count': '12.5K'},
    {'tag': '#IslandLife', 'count': '8.3K'},
    {'tag': '#LimeMusic', 'count': '6.7K'},
    {'tag': '#CommunityFirst', 'count': '5.2K'},
    {'tag': '#TravelDiaries', 'count': '4.1K'},
    {'tag': '#LocalArt', 'count': '3.8K'},
  ];

  final List<Map<String, String>> popularUsers = [
    {'name': 'Alex Rivera', 'handle': '@alexrivera', 'followers': '45.2K'},
    {'name': 'Jazz Events', 'handle': '@jazzevents', 'followers': '32.1K'},
    {'name': 'Island Adventures', 'handle': '@islandadv', 'followers': '28.5K'},
    {'name': 'Caribbean Crew', 'handle': '@caribcrew', 'followers': '19.7K'},
  ];

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
          'Search',
          style: TextStyle(
            color: LimeColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
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
                  onChanged: (value) {
                    setState(() {
                      _isSearching = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search posts, people, tags...',
                    hintStyle: const TextStyle(color: LimeColors.textTertiary),
                    prefixIcon: const Icon(Icons.search, color: LimeColors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (!_isSearching) ...[
                // Trending section
                const Text(
                  'Trending Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: LimeColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: trendingTags.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: LimeColors.cardBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: LimeColors.borderLight,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            trendingTags[index]['tag']!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: LimeColors.textPrimary,
                            ),
                          ),
                          Text(
                            '${trendingTags[index]['count']} posts',
                            style: const TextStyle(
                              fontSize: 11,
                              color: LimeColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Popular users section
                const Text(
                  'Popular Users',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: LimeColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  popularUsers.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: LimeColors.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: LimeColors.borderLight,
                        width: 1,
                      ),
                    ),
                    child: Row(
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
                                popularUsers[index]['name']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: LimeColors.textPrimary,
                                ),
                              ),
                              Text(
                                popularUsers[index]['handle']!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: LimeColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${popularUsers[index]['followers']}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: LimeColors.accentGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
