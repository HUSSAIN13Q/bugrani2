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
    return Container(
      margin: EdgeInsets.only(left: 16), // Add left margin
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Set background to white
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(subtitle, style: TextStyle(fontWeight: FontWeight.bold)),
          if (date.isNotEmpty) Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
