import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'leaves_page.dart';
import 'widgets/BusinessCardDialog.dart';
import 'widgets/MapSection.dart';
import 'widgets/SpecialOffersSection.dart';
import 'widgets/UpcomingMeetingsSection.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF2C80E6),
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'images/orangelogoonly.png',
            height: 40,
          ),
          leading: IconButton(
            icon: Icon(Icons.badge_outlined, size: 30, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => BusinessCardDialog(),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white, size: 30),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 7,
              child: HeaderSection(),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    MapSection(),
                    SizedBox(height: 16), // Space between MapSection and LeavesPageButton
                    LeavesPageButton(),
                    SizedBox(height: 16), // Space between LeavesPageButton and SpecialOffersSection
                    SpecialOffersSection(), // Add SpecialOffersSection here
                    SizedBox(height: 16), // Space before UpcomingMeetingsSection
                    UpcomingMeetingsSection(), // Add UpcomingMeetingsSection here
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'News',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }
}

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
  bool isCheckedOut = false;
  String workMessage = '';

  void _checkIn() {
    final now = DateTime.now();
    final onTimeStart = DateFormat('HH:mm').parse('07:00');
    final onTimeEnd = DateFormat('HH:mm').parse('08:30');
    final lateEndTime = DateFormat('HH:mm').parse('19:00');

    setState(() {
      checkInTime = DateFormat('hh:mm a').format(now);
      if (now.isAfter(onTimeEnd) && now.isBefore(lateEndTime)) {
        checkInStatus = 'late';
        lateMinutes = now.difference(onTimeEnd).inMinutes;
      } else if (now.isAfter(onTimeStart) && now.isBefore(onTimeEnd)) {
        checkInStatus = 'on time';
        lateMinutes = 0;
      }
      isCheckedIn = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/map.png'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Check In',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _checkOut() {
    final now = DateTime.now();
    final checkInDateTime = DateFormat('hh:mm a').parse(checkInTime);
    final workDuration = now.difference(checkInDateTime);
    final workHours = workDuration.inHours;
    final workMinutes = workDuration.inMinutes % 60;

    setState(() {
      checkOutTime = DateFormat('hh:mm a').format(now);
      isCheckedOut = true;
      workMessage = 'You completed ${workHours > 0 ? '$workHours hours and ' : ''}$workMinutes minutes today';
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/map.png'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Check Out',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
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
      child: SafeArea(
        child: Column(
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
                        value: lateMinutes >= 60 ? '${(lateMinutes / 60).floor()}' : '$lateMinutes',
                        unit: lateMinutes >= 60 ? 'hours' : 'Minutes',
                        valueColor: Colors.orange,
                      ),
                      VerticalDivider(color: Colors.grey),
                      WorkStats(title: 'Overtime', value: '15', unit: 'Hours'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCheckedIn ? _checkOut : _checkIn,
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
                      isCheckedIn ? 'Click to Check Out' : 'Click to Check In',
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CheckButton(
                  title: 'Check in',
                  time: checkInTime,
                  status: checkInStatus,
                  icon: Icons.check_circle,
                ),
                SizedBox(width: 16),
                CheckButton(
                  title: 'Check out',
                  time: checkOutTime,
                  status: checkInStatus,
                  icon: Icons.logout,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeavesPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LeavesPage()),
          );
        },
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Adjust shadow color
                blurRadius: 10, // Shadow blur radius
                offset: Offset(0, 4), // Shadow offset
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Leaves Page',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CheckButton extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final IconData icon;
  final Color? statusColor;

  const CheckButton({required this.title, required this.time, required this.status, required this.icon, this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 130,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(time.isEmpty ? '-' : time, style: TextStyle(fontWeight: FontWeight.bold)),
          if (status.isNotEmpty)
            Text(
              status,
              style: TextStyle(color: statusColor ?? (status == 'on time' ? Colors.green : Colors.red), fontSize: 12),
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
  final Color? unitColor;

  const WorkStats({required this.title, required this.value, required this.unit, this.valueColor, this.unitColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: valueColor ?? Colors.orange)),
        if (unit.isNotEmpty) Text(unit, style: TextStyle(color: unitColor ?? Colors.black)),
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionContainer({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
