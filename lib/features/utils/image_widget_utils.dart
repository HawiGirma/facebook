import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidgetUtils {
  static CachedNetworkImage buildCachedImage({
    required String imageUrl,
    BoxFit fit = BoxFit.cover,
    int? memCacheWidth,
    int? memCacheHeight,
    int? maxWidthDiskCache,
    int? maxHeightDiskCache,
    PlaceholderWidgetBuilder? placeholder,
    LoadingErrorWidgetBuilder? errorWidget,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      useOldImageOnUrlChange: true,
      placeholder: placeholder ??
          (context, url) => Container(color: Colors.grey[200]),
      errorWidget: errorWidget ??
          (context, url, error) => Container(
                color: Colors.grey[300],
                child: Icon(Icons.error, size: 30),
              ),
    );
  }

  static CachedNetworkImage buildStoryImage(String imageUrl) {
    return buildCachedImage(
      imageUrl: imageUrl,
      memCacheWidth: 240,
      memCacheHeight: 320,
      maxWidthDiskCache: 240,
      maxHeightDiskCache: 320,
    );
  }

  static Widget buildPostImage(String imageUrl) {
    return SizedBox(
      width: double.infinity,
      child: buildCachedImage(
        imageUrl: imageUrl,
        memCacheWidth: 600,
        memCacheHeight: 400,
        maxWidthDiskCache: 600,
        maxHeightDiskCache: 400,
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
    );
  }
}

