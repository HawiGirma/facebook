import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:facebook/features/services/auth_service.dart';
import 'package:facebook/features/utils/app_constants.dart';
import 'package:facebook/features/utils/widget_utils.dart';
import 'package:facebook/features/screen/Login_Screen.dart';
import 'package:facebook/features/screen/Profile_Screen.dart';
import 'package:facebook/features/screen/Notification_Screen.dart';
import 'package:facebook/features/screen/widgets/HomeFeedWidget.dart';
import 'package:facebook/features/screen/widgets/VideoScreen.dart';
import 'package:facebook/features/screen/widgets/PeopleScreen.dart';
import 'package:facebook/features/screen/widgets/ShopScreen.dart';
import 'package:facebook/features/screen/widgets/MenuScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  User? _user;
  int _selectedIndex = 0; // Track selected navigation index

  @override
  void initState() {
    super.initState();
    _user = _authService.currentUser;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'facebook';
      case 1:
        return 'Watch';
      case 2:
        return 'Friends';
      case 3:
        return 'Marketplace';
      case 4:
        return 'Notifications';
      case 5:
        return 'Menu';
      default:
        return 'facebook';
    }
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
        WidgetUtils.showErrorSnackBar(
          context,
          'Error signing out: ${e.toString()}',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(), style: AppConstants.appBarTitleStyle),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.message)),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeFeedWidget(user: _user),
          VideoScreen(),
          PeopleScreen(),
          ShopScreen(),
          NotificationScreen(),
          MenuScreen(user: _user, onLogout: _logout),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.video_chat), label: 'Watch'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Marketplace'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}
