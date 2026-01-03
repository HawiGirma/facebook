import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color.fromARGB(255, 2, 109, 196);
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;

  // Text Styles
  static const TextStyle appBarTitleStyle = TextStyle(
    color: primaryColor,
    fontFamily: 'FacebookSans',
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  static const TextStyle appBarSubtitleStyle = TextStyle(
    color: primaryColor,
    fontFamily: 'FacebookSans',
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  // Durations
  static const Duration snackBarDuration = Duration(seconds: 4);
  static const Duration splashDelay = Duration(seconds: 2);

  // Post Descriptions
  static const List<String> postDescriptions = [
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

