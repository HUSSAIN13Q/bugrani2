import 'package:flutter/material.dart';

class MapSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Map for Head Office',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        FloorMapButton(title: 'Ground Floor Map'),
        Divider(),
        FloorMapButton(title: 'First Floor Map'),
        Divider(),
        FloorMapButton(title: 'Second Floor Map'),
      ],
    );
  }
}

class FloorMapButton extends StatelessWidget {
  final String title;

  const FloorMapButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Icon(Icons.map),
      ],
    );
  }
}
