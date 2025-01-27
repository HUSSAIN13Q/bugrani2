import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int? _selectedCardIndex;

  void _onCardTap(int index) {
    setState(() {
      _selectedCardIndex = _selectedCardIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue AppBar with Title and Logo
          Stack(
            children: [
              Container(
                height: 150, // Reduced the height of the blue container
                decoration: BoxDecoration(
                  color: Color(0xFF2C80E6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 50,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: Image.asset(
                  'assets/images/orangelogoonly.png',
                  height: 50,
                ),
              ),
              Positioned(
                top: 110,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return AnimatedNotificationCard(
                  title: _notifications[index]['title'] as String,
                  message: _notifications[index]['message'] as String,
                  icon: _notifications[index]['icon'] as IconData,
                  iconColor: _notifications[index]['iconColor'] as Color,
                  date: _notifications[index]['date'] as String,
                  isSelected: _selectedCardIndex == index,
                  onTap: () => _onCardTap(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

const _notifications = [
  {
    'title': "Leave Request Status",
    'message': "Your leave request is pending.",
    'icon': Icons.pending_actions,
    'iconColor': Colors.orange,
    'date': "2023-10-01",
  },
  {
    'title': "Community Announcement",
    'message': "There will be a community meeting on Friday at 5 PM.",
    'icon': Icons.announcement,
    'iconColor': Colors.blue,
    'date': "2023-10-02",
  },
  {
    'title': "Bank News",
    'message': "Our bank has introduced new savings plans. Check them out!",
    'icon': Icons.account_balance,
    'iconColor': Colors.orange,
    'date': "2023-10-03",
  },
  {
    'title': "Bank News",
    'message': "We are offering special loan rates this month.",
    'icon': Icons.account_balance_wallet,
    'iconColor': Colors.orange,
    'date': "2023-10-04",
  },
  {
    'title': "Employee Announcement",
    'message': "Burgan Bank is hosting a wellness workshop next Wednesday.",
    'icon': Icons.local_hospital,
    'iconColor': Colors.blue,
    'date': "2023-10-05",
  },
  {
    'title': "Employee Announcement",
    'message': "New employee benefits have been added. Check your email for details.",
    'icon': Icons.email,
    'iconColor': Colors.blue,
    'date': "2023-10-06",
  },
  {
    'title': "Upcoming Holiday",
    'message': "Reminder: The office will be closed on February 25th for Kuwait National Day.",
    'icon': Icons.holiday_village,
    'iconColor': Colors.blue,
    'date': "2023-10-07",
  },
  {
    'title': "Upcoming Meeting",
    'message': "Don't forget the team meeting scheduled for Monday at 10 AM.",
    'icon': Icons.meeting_room,
    'iconColor': Colors.orange,
    'date': "2023-10-08",
  },
  {
    'title': "Upcoming Event",
    'message': "The annual company picnic is scheduled for next Saturday.",
    'icon': Icons.event,
    'iconColor': Colors.blue,
    'date': "2023-10-09",
  },
];

class AnimatedNotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const AnimatedNotificationCard({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.date,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.1 : 1.0,
        duration: Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(icon, color: iconColor),
                title: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
