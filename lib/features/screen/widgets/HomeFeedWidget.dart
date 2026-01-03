import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:facebook/features/services/unsplash_image_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeFeedWidget extends StatefulWidget {
  final User? user;

  const HomeFeedWidget({super.key, this.user});

  @override
  State<HomeFeedWidget> createState() => _HomeFeedWidgetState();
}

class _HomeFeedWidgetState extends State<HomeFeedWidget> {
  late List<String> _storyImages;
  late List<Map<String, String>> _posts;
  final Map<int, bool> _likedPosts = {};
  final Map<int, int> _likeCounts = {};

  @override
  void initState() {
    super.initState();
    _storyImages = UnsplashImageService.getStoryImages(count: 8);
    _posts = _generatePosts(count: 5);
    _preloadImages();
  }

  List<Map<String, String>> _generatePosts({int count = 5}) {
    final postImages = UnsplashImageService.getPostImages(count: count);
    final descriptions = _getPostDescriptions();
    final random = DateTime.now().millisecondsSinceEpoch;

    return List.generate(count, (index) {
      _likedPosts[index] = false;
      _likeCounts[index] = (random + index) % 50;
      return {
        'imageUrl': postImages[index],
        'description': descriptions[(random + index) % descriptions.length],
      };
    });
  }

  List<String> _getPostDescriptions() {
    return [
      'Beautiful sunset today! 🌅 Nature never fails to amaze me.',
      'Just finished reading an amazing book. Highly recommend it!',
      'Coffee and coding - the perfect morning routine ☕',
      'Weekend vibes! Time to relax and recharge.',
      'New project in the works. Excited to share it soon!',
      'Grateful for all the amazing people in my life ❤️',
      'Working on something special. Stay tuned!',
      'Life is beautiful when you appreciate the little things.',
      'Just discovered this amazing place. You have to visit!',
      'Productivity mode: ON 💪 Let\'s make today count!',
      'Sometimes the best moments are the simplest ones.',
      'Dream big, work hard, stay focused. That\'s the plan!',
      'Nature is the best therapy. Feeling refreshed!',
      'New day, new opportunities. Let\'s make it great!',
      'Sharing some thoughts and positive energy today ✨',
    ];
  }

  void _preloadImages() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < _storyImages.length && i < 3; i++) {
        precacheImage(CachedNetworkImageProvider(_storyImages[i]), context);
      }
      if (_posts.isNotEmpty) {
        precacheImage(
          CachedNetworkImageProvider(_posts[0]['imageUrl']!),
          context,
        );
      }
    });
  }

  Future<void> _loadImages() async {
    setState(() {
      _storyImages = UnsplashImageService.getStoryImages(count: 8);
      _likedPosts.clear();
      _likeCounts.clear();
      _posts = _generatePosts(count: 5);
    });
  }

  void _toggleLike(int postIndex) {
    setState(() {
      final isLiked = _likedPosts[postIndex] ?? false;
      _likedPosts[postIndex] = !isLiked;
      final currentCount = _likeCounts[postIndex] ?? 0;
      _likeCounts[postIndex] = isLiked ? currentCount - 1 : currentCount + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadImages,
      child: ListView(
        children: [
          SizedBox(height: 16),
          // Create Post Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: widget.user?.photoURL != null
                      ? NetworkImage(widget.user!.photoURL!)
                      : null,
                  child: widget.user?.photoURL == null
                      ? Icon(Icons.person, size: 20)
                      : null,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 2, 109, 196),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.image, color: Colors.green),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Stories Section
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemCount: _storyImages.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: _storyImages[index],
                      fit: BoxFit.cover,
                      memCacheWidth: 240,
                      memCacheHeight: 320,
                      maxWidthDiskCache: 240,
                      maxHeightDiskCache: 320,
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      placeholderFadeInDuration: Duration.zero,
                      useOldImageOnUrlChange: true,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.error, size: 30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Posts Section
          ..._posts.asMap().entries.map((entry) {
            final index = entry.key;
            final post = entry.value;
            return _buildPostCard(post, index);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, String> post, int postIndex) {
    final imageUrl = post['imageUrl']!;
    final description = post['description']!;
    final isLiked = _likedPosts[postIndex] ?? false;
    final likeCount = _likeCounts[postIndex] ?? 0;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: widget.user?.photoURL != null
                      ? NetworkImage(widget.user!.photoURL!)
                      : null,
                  child: widget.user?.photoURL == null
                      ? Icon(Icons.person, size: 20)
                      : null,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user?.displayName ?? 'User',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'just now',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Post Description
          if (description.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          // Post Image
          CachedNetworkImage(
            imageUrl: imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            memCacheWidth: 600,
            memCacheHeight: 400,
            maxWidthDiskCache: 600,
            maxHeightDiskCache: 400,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            placeholderFadeInDuration: Duration.zero,
            useOldImageOnUrlChange: true,
            placeholder: (context, url) =>
                Container(height: 300, color: Colors.grey[200]),
            errorWidget: (context, url, error) => Container(
              height: 300,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 50, color: Colors.grey[600]),
                  SizedBox(height: 8),
                  Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          // Post Actions
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                if (likeCount > 0)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                        SizedBox(width: 4),
                        Text(
                          '$likeCount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _toggleLike(postIndex),
                          icon: Icon(
                            isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            color: isLiked ? Colors.blue : Colors.grey[600],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.comment_outlined,
                            color: Colors.grey[600],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share_outlined, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

