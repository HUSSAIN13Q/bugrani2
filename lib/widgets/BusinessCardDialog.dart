import 'package:flutter/material.dart';

class BusinessCardDialog extends StatelessWidget {
  const BusinessCardDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'images/burganlogo.png',
                  width: 50,
                  height: 50,
                ),
                Text(
                  'Burgan business card',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  'images/meshriBcard.png',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Meshari Alhouli',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Burgan Bank Employee :\n UI Design in IT Department',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Office Number: 22255321',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Phone Number: 98979686',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Email: Mesharialhouli@burgan.com',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 12,
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
