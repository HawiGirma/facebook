import 'dart:math';

class UnsplashImageService {
  // Unsplash Source API - no API key required
  // Using different image categories for variety
  static const List<String> _categories = [
    'nature',
    'city',
    'people',
    'technology',
    'architecture',
    'travel',
    'food',
    'animals',
    'sports',
    'business',
  ];

  // Generate random Unsplash image URLs
  static List<String> getRandomImageUrls({
    int count = 10,
    int width = 400,
    int height = 300,
  }) {
    final random = Random();
    final List<String> urls = [];

    for (int i = 0; i < count; i++) {
      // Use Unsplash Source with random category
      final category = _categories[random.nextInt(_categories.length)];
      final url = 'https://source.unsplash.com/${width}x${height}/?$category&sig=${random.nextInt(10000)}';
      urls.add(url);
    }

    return urls;
  }

  // Alternative: Use Picsum Photos (simpler, more reliable)
  // Using smaller dimensions and grayscale for faster loading
  static List<String> getPicsumImageUrls({
    int count = 10,
    int width = 400,
    int height = 300,
  }) {
    final random = Random();
    final List<String> urls = [];

    for (int i = 0; i < count; i++) {
      final imageId = random.nextInt(1000);
      // Using ?random parameter for better caching and faster response
      final url = 'https://picsum.photos/$width/$height?random=$imageId';
      urls.add(url);
    }

    return urls;
  }

  // Get images for stories (horizontal scroll) - smaller for faster loading
  static List<String> getStoryImages({int count = 5}) {
    return getPicsumImageUrls(count: count, width: 120, height: 160);
  }

  // Get images for posts (vertical feed) - optimized size
  static List<String> getPostImages({int count = 10}) {
    return getPicsumImageUrls(count: count, width: 600, height: 400);
  }
}

