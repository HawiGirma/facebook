import 'dart:math';

class UnsplashImageService {
  // Use Picsum Photos (simple, reliable, no API key required)
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

