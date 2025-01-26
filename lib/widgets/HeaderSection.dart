import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class HeaderSection extends StatelessWidget {
  final bool isExpanded;

  const HeaderSection({Key? key, required this.isExpanded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

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
                blurRadius: 50,
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
                  WorkStats(title: 'Work Hours', value: '', unit: 'Hours'),
                ],
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: attendanceProvider.isLoading
                  ? null
                  : () {
                      _showCheckInOutDialog(context, attendanceProvider);
                    },
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
                    attendanceProvider.isCheckedIn
                        ? 'Click to Check Out'
                        : 'Click to Check In',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
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
                        blurRadius: 50,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CheckButton(
                    title: 'Check In',
                    status: attendanceProvider.isCheckedIn
                        ? 'Checked In at ${_formatTime(attendanceProvider.checkInTime)}'
                        : 'Not Checked In',
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
                        blurRadius: 50,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CheckButton(
                    title: 'Check Out',
                    status: attendanceProvider.isCheckedIn
                        ? 'Not Checked Out'
                        : 'Checked Out at ${_formatTime(attendanceProvider.checkOutTime)}',
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

  String _formatTime(String dateTime) {
    if (dateTime.isEmpty) {
      return 'Invalid time';
    }
    try {
      final time = DateTime.parse(dateTime).toLocal();
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Invalid time';
    }
  }

  void _showCheckInOutDialog(
      BuildContext context, AttendanceProvider attendanceProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  attendanceProvider.isCheckedIn ? 'Check Out' : 'Check In',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: attendanceProvider.isLoading
                      ? null
                      : () async {
                          try {
                            if (attendanceProvider.isCheckedIn) {
                              await attendanceProvider.checkOut(
                                  25.276987, 55.296249);
                            } else {
                              await attendanceProvider.checkIn(
                                  25.276987, 55.296249);
                            }
                            Navigator.pop(context);
                          } catch (error) {
                            Navigator.pop(context);
                            _showErrorDialog(context, error.toString());
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: attendanceProvider.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          attendanceProvider.isCheckedIn
                              ? 'Check Out'
                              : 'Check In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class CheckButton extends StatelessWidget {
  final String title;
  final String status;
  final IconData icon;
  final VoidCallback onPressed;

  const CheckButton({
    Key? key,
    required this.title,
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
