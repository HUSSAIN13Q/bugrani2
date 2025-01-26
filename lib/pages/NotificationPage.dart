import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
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
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _notificationCard(
                  context,
                  "Leave Request Status",
                  "Your leave request is pending.",
                  Icons.pending_actions,
                  Colors.orange,
                  "2023-10-01",
                ),
                _notificationCard(
                  context,
                  "Community Announcement",
                  "There will be a community meeting on Friday at 5 PM.",
                  Icons.announcement,
                  Colors.blue,
                  "2023-10-02",
                ),
                _notificationCard(
                  context,
                  "Bank News",
                  "Our bank has introduced new savings plans. Check them out!",
                  Icons.account_balance,
                  Colors.orange,
                  "2023-10-03",
                ),
                _notificationCard(
                  context,
                  "Bank News",
                  "We are offering special loan rates this month.",
                  Icons.account_balance_wallet,
                  Colors.orange,
                  "2023-10-04",
                ),
                _notificationCard(
                  context,
                  "Employee Announcement",
                  "Burgan Bank is hosting a wellness workshop next Wednesday.",
                  Icons.local_hospital,
                  Colors.blue,
                  "2023-10-05",
                ),
                _notificationCard(
                  context,
                  "Employee Announcement",
                  "New employee benefits have been added. Check your email for details.",
                  Icons.email,
                  Colors.blue,
                  "2023-10-06",
                ),
                _notificationCard(
                  context,
                  "Upcoming Holiday",
                  "Reminder: The office will be closed on February 25th for Kuwait National Day.",
                  Icons.holiday_village,
                  Colors.blue,
                  "2023-10-07",
                ),
                _notificationCard(
                  context,
                  "Upcoming Meeting",
                  "Don't forget the team meeting scheduled for Monday at 10 AM.",
                  Icons.meeting_room,
                  Colors.orange,
                  "2023-10-08",
                ),
                _notificationCard(
                  context,
                  "Upcoming Event",
                  "The annual company picnic is scheduled for next Saturday.",
                  Icons.event,
                  Colors.blue,
                  "2023-10-09",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationCard(BuildContext context, String title, String message, IconData icon, Color iconColor, String date) {
    return Column(
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
    );
  }
}
