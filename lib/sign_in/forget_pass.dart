import 'package:flutter/material.dart';

class ForgetPassPage extends StatelessWidget {
  const ForgetPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'New Pin',
                filled: true,
                fillColor: const Color(0xFFF7F7F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Retype New Pin',
                filled: true,
                fillColor: const Color(0xFFF7F7F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add submit logic here
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
