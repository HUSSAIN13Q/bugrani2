import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPassPage extends StatelessWidget {
  const ForgetPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Status Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 51,
              padding: const EdgeInsets.only(top: 21),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Logo
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'images/lastlogo.png',
                width: 400,
                height: 400,
              ),
            ),
          ),

          // Blue Container with Form
          Positioned(
            bottom: -100,
            left: 0,
            right: 0,
            child: Container(
              height: 541,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF2C80E6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20), // Add space above the New Pin
                  const Text(
                    'New Pin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      hintText: 'New Pin',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 20,
                      ),
                      counterStyle: const TextStyle(color: Colors.white), // Make 0/4 white
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Retype New Pin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      hintText: 'Retype New Pin',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 20,
                      ),
                      counterStyle: const TextStyle(color: Colors.white), // Make 0/4 white
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40), // Add space above the button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFB8E36),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20), // Increase button size
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold), // Increase font size and make bold
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Change font color to white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add space below the button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
