import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderSection extends StatefulWidget {
  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  String checkInStatus = '';
  String checkInTime = '-';
  String checkOutTime = '-';
  int lateMinutes = 0;
  bool isCheckedIn = false;

  void _checkIn() {
    final now = DateTime.now();
    final onTimeEnd = DateFormat('HH:mm').parse('08:30');

    setState(() {
      checkInTime = DateFormat('hh:mm a').format(now);
      checkInStatus = now.isBefore(onTimeEnd) ? 'on time' : 'late';
      isCheckedIn = true;
    });
  }

  void _checkOut() {
    final now = DateTime.now();
    setState(() {
      checkOutTime = DateFormat('hh:mm a').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2C80E6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meshari alhouli',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('UI Design / IT Department'),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckButton(
                title: 'Check In',
                time: checkInTime,
                status: checkInStatus,
                icon: Icons.check_circle,
              ),
              CheckButton(
                title: 'Check Out',
                time: checkOutTime,
                status: '',
                icon: Icons.logout,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckButton extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final IconData icon;

  const CheckButton({required this.title, required this.time, required this.status, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16)),
          Text(time, style: TextStyle(fontWeight: FontWeight.bold)),
          if (status.isNotEmpty)
            Text(
              status,
              style: TextStyle(color: status == 'on time' ? Colors.green : Colors.red),
            ),
        ],
      ),
    );
  }
}
