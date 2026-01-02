import 'package:flutter/material.dart';
import 'package:facebook/features/screen/Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/facebook.png', color: Colors.green),
            ElevatedButton(
              onPressed: () {
                LoginScreen();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: Text('Start'),
              // style: ButtonStyle(const color: Colors.green,
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
