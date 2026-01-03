import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: const Color.fromARGB(255, 2, 109, 196),
            fontFamily: 'FacebookSans',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          // Notification Header
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 2, 109, 196),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Notification Items
          _buildNotificationItem(
            icon: Icons.thumb_up,
            iconColor: Colors.blue,
            title: 'John Doe liked your post',
            subtitle: '2 hours ago',
            isRead: false,
          ),
          _buildNotificationItem(
            icon: Icons.comment,
            iconColor: Colors.green,
            title: 'Sarah Smith commented on your post',
            subtitle: '5 hours ago',
            isRead: false,
          ),
          _buildNotificationItem(
            icon: Icons.person_add,
            iconColor: Colors.orange,
            title: 'Mike Johnson sent you a friend request',
            subtitle: '1 day ago',
            isRead: true,
          ),
          _buildNotificationItem(
            icon: Icons.share,
            iconColor: Colors.purple,
            title: 'Emma Wilson shared your post',
            subtitle: '2 days ago',
            isRead: true,
          ),
          _buildNotificationItem(
            icon: Icons.tag,
            iconColor: Colors.red,
            title: 'You were tagged in a photo',
            subtitle: '3 days ago',
            isRead: true,
          ),
          _buildNotificationItem(
            icon: Icons.event,
            iconColor: Colors.teal,
            title: 'New event: Tech Meetup',
            subtitle: '1 week ago',
            isRead: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isRead,
  }) {
    return Container(
      color: isRead ? Colors.white : Colors.blue[50],
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: isRead
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
        onTap: () {},
      ),
    );
  }
}

