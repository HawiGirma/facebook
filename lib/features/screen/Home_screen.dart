import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:facebook/features/services/auth_service.dart';
import 'package:facebook/features/screen/Login_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _authService.currentUser;
  }

  Future<void> _logout() async {
    try {
      await _authService.signOut();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'facebook',
          style: TextStyle(
            color: const Color.fromARGB(255, 2, 109, 196),
            fontFamily: 'FacebookSans',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.message)),
          PopupMenuButton(
            icon: Icon(Icons.account_circle),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
                onTap: _logout,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // User Info Section
            if (_user != null)
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey[100],
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: _user!.photoURL != null
                          ? NetworkImage(_user!.photoURL!)
                          : null,
                      child: _user!.photoURL == null
                          ? Icon(Icons.person, size: 30)
                          : null,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _user!.displayName ?? 'User',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _user!.email ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),

                IconButton(
                  icon: Icon(Icons.home, color: Colors.grey, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.video_chat, color: Colors.grey, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.people, color: Colors.grey, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.shop, color: Colors.grey, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.grey, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.grey, size: 30),
                  onPressed: () {},
                ),
                SizedBox(width: 10),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(
                    'assets/images/facebook.png',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.image)),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    '/assets/images/facebook.png',
                    width: 50,
                    height: 150,
                  ),
                  Image.asset(
                    '/assets/images/facebook.png',
                    width: 50,
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/facebook.png',
                    width: 50,
                    height: 150,
                  ),
                  Image.asset(
                    '/assets/images/facebook.png',
                    width: 50,
                    height: 150,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage(
                        '/assets/images/facebook.png',
                      ),
                    ),
                    Column(
                      children: [
                        Text('John Doe'),
                        Text(
                          'just now',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more)),
                  ],
                ),
                Text('lorem ipsum '),
                Image(image: AssetImage('assets/images/facebook.png')),
                Image(image: AssetImage('/assets/images/facebook.png')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
