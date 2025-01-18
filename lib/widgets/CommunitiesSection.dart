import 'package:flutter/material.dart';

class CommunitiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Communities',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        CommunityItem(
          title: 'Football Team Club',
          subtitle: 'Announcement: Admin: All the players will be invited ...',
          date: '03/01/2025',
        ),
        Divider(),
        CommunityItem(
          title: 'Financial Literacy Workshop',
          subtitle: 'Workshop details to be announced.',
          date: '',
        ),
      ],
    );
  }
}

class CommunityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;

  const CommunityItem({required this.title, required this.subtitle, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(subtitle),
        if (date.isNotEmpty) Text(date),
      ],
    );
  }
}
