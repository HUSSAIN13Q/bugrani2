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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 50,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meshari alhouli',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'UI Design / IT Department',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text(
                'Total work this month',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const WorkStats(
                      title: 'Working day', value: '30', unit: 'Days'),
                  const VerticalDivider(color: Colors.grey),
                  const WorkStats(
                    title: 'Late',
                    value: '0',
                    unit: 'Minutes',
                    valueColor: Colors.orange,
                  ),
                  const VerticalDivider(color: Colors.grey),
                  WorkStats(
                      title: 'Work Hours',
                      value: attendanceProvider.workHours.toStringAsFixed(2),
                      unit: 'Hours'),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 50,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CheckButton(
                    title: 'Check In',
                    status: attendanceProvider.hasCheckedInToday
                        ? 'Checked In at ${_formatTime(attendanceProvider.checkInTime)}'
                        : 'Not Checked In',
                    icon: Icons.check_circle,
                    onPressed: attendanceProvider.isLoading ||
                            attendanceProvider.hasCheckedInToday
                        ? null
                        : () async {
                            await _showCheckInOutDialog(
                                context, attendanceProvider, true);
                          },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 50,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CheckButton(
                    title: 'Check Out',
                    status: attendanceProvider.hasCheckedOutToday
                        ? 'Checked Out at ${_formatTime(attendanceProvider.checkOutTime)}'
                        : 'Not Checked Out',
                    icon: Icons.logout,
                    onPressed: attendanceProvider.isLoading ||
                            !attendanceProvider.isCheckedIn
                        ? null
                        : () async {
                            await _showCheckInOutDialog(
                                context, attendanceProvider, false);
                          },
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

  Future<void> _showCheckInOutDialog(
    BuildContext context,
    AttendanceProvider attendanceProvider,
    bool isCheckIn,
  ) async {
    String action = isCheckIn ? 'Check In' : 'Check Out';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      action,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      'images/newsmap.png',
                      width: double.infinity, // Extend to dialog border
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double
                          .infinity, // Make button width like dialog width
                      child: ElevatedButton(
                        onPressed: attendanceProvider.isLoading
                            ? null
                            : () async {
                                try {
                                  if (isCheckIn) {
                                    await attendanceProvider.checkIn(
                                        25.276987, 55.296249);
                                    Navigator.pop(context);
                                    _showSuccessDialog(
                                        context, 'Check-In Successful');
                                  } else {
                                    await attendanceProvider.checkOut(
                                        25.276987, 55.296249);
                                    Navigator.pop(context);
                                    _showSuccessDialog(
                                        context, 'Check-Out Successful');
                                  }
                                } catch (error) {
                                  Navigator.pop(context);
                                  _showErrorDialog(context, error.toString());
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(
                              vertical: 20), // Increased padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: attendanceProvider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                action,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18, // Increased font size
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Success',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
  final VoidCallback? onPressed;

  const CheckButton({
    Key? key,
    required this.title,
    required this.status,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            size: 50, // Increased icon size
            color: onPressed == null ? Colors.grey : Colors.orange,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold), // Increased font size
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: const TextStyle(
                fontSize: 16, color: Colors.black54), // Increased font size
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          unit,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
