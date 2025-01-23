import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderSection extends StatefulWidget {
  final bool isExpanded;

  const HeaderSection({Key? key, required this.isExpanded}) : super(key: key);

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  String checkInStatus = '';
  String checkInTime = '-';
  String checkOutTime = '-';
  bool isCheckedIn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'UI Design / IT Department',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 16),
              Text(
                'Total work this month',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WorkStats(title: 'Working day', value: '30', unit: 'Days'),
                  VerticalDivider(color: Colors.grey),
                  WorkStats(
                    title: 'Late',
                    value: '0',
                    unit: 'Minutes',
                    valueColor: Colors.orange,
                  ),
                  VerticalDivider(color: Colors.grey),
                  WorkStats(title: 'Overtime', value: '15', unit: 'Hours'),
                ],
              ),
            ],
          ),
        ),
        if (widget.isExpanded) ...[
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.ads_click_outlined, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Click to Check In',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          // Check In and Check Out Buttons side by side
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
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
                  child: CheckButton(
                    title: 'Check In',
                    time: checkInTime,
                    status: checkInStatus,
                    icon: Icons.check_circle,
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
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
                  child: CheckButton(
                    title: 'Check Out',
                    time: checkOutTime,
                    status: '',
                    icon: Icons.logout,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class CheckButton extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final IconData icon;
  final VoidCallback onPressed;

  const CheckButton({
    Key? key,
    required this.title,
    required this.time,
    required this.status,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.orange),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class WorkStats extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Color? valueColor;

  const WorkStats({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          unit,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}

