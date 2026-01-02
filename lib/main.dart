import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:facebook/firebase_options.dart';
import 'package:facebook/features/screen/SplashScreen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase with the generated options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print('Firebase initialized successfully');
    }
  } catch (e) {
    // Firebase not configured yet - app will still run but auth won't work
    if (kDebugMode) {
      print('Firebase initialization error: $e');
      print('⚠️ Please configure Firebase:');
      print('   1. Create Firebase project at https://console.firebase.google.com');
      print('   2. Add google-services.json to android/app/ (for Android)');
      print('   3. Or run: flutterfire configure (recommended)');
    }
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
