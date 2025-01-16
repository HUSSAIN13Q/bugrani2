import 'package:flutter/material.dart';

class ForgetPassPage extends StatelessWidget {
  const ForgetPassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: screenWidth * -0.02,
              top: screenHeight * 0.54,
              child: Container(
                width: screenWidth * 1.03,
                height: screenHeight * 0.57,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C80E6),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.13,
              top: screenHeight * 0.58,
              child: Text(
                'Type the OTP:',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.52,
              top: screenHeight * 0.56,
              child: Container(
                width: screenWidth * 0.38,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFB8B8B8),
                    width: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.13,
              top: screenHeight * 0.67,
              child: Text(
                'New Pin',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.52,
              top: screenHeight * 0.65,
              child: Container(
                width: screenWidth * 0.38,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFB8B8B8),
                    width: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.12,
              top: screenHeight * 0.77,
              child: Text(
                'Retype New Pin',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.52,
              top: screenHeight * 0.75,
              child: Container(
                width: screenWidth * 0.38,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFB8B8B8),
                    width: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.12,
              top: screenHeight * 0.9,
              child: GestureDetector(
                onTap: () {
                  // Add sign in logic here
                },
                child: Container(
                  width: screenWidth * 0.76,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB8E36),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
