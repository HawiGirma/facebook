import 'package:flutter/material.dart';
import 'package:facebook/features/services/auth_service.dart';
import 'package:facebook/features/screen/Login_Screen.dart';
import 'package:facebook/features/screen/Home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    // Wait for Firebase to initialize and check auth state
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check if user is already signed in
    final user = _authService.currentUser;

    if (user != null) {
      // User is authenticated, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // User is not authenticated, navigate to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Facebook Logo
            Image.asset(
              'assets/images/facebook.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 2, 109, 196),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// if there is classname before the class it is static class
// For splash screen delay we have to way
//Duration class (sec:3)
//Timer- once, periodic(continously  check for the time)
//Future delayed
