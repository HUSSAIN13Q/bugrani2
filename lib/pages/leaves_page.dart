import 'package:flutter/material.dart';

class LeavesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C80E6),
        title: Text('Leaves Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to the Leaves Page!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
