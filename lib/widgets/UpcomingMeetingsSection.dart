import 'package:flutter/material.dart';

class UpcomingMeetingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Meetings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        MeetingItem(
          title: 'Design Team Meeting',
          description: 'Lead by Reem Alhussaini on Burgan Lab, 01/feb/2025',
          time: '12:30 PM',
        ),
        Divider(),
        MeetingItem(
          title: 'Backend Planning Meeting',
          description: 'Lead by Hussain Alsaffar on Burgan Lab, 01/feb/2025',
          time: '02:30 PM',
        ),
      ],
    );
  }
}

class MeetingItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const MeetingItem({required this.title, required this.description, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(time),
          ],
        ),
        Text(description),
      ],
    );
  }
}
