import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Logo
          // Positioned(
          //   top: 80,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Image.asset(
          //       ' assets/images/lastlogo.png',
          //       width: 400,
          //       height: 400,
          //     ),
          //   ),
          // ),

          // Blue Container with Login Form
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
                  const SizedBox(height: 20), // Add space above the username
                  const Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9D9D9D),
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Enter Your PIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF7F7F7),
                      hintText: '4-Digit Pin',
                      hintStyle: const TextStyle(
                        color: Color(0xFF949494),
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        context.push('/forget_pass');
                      },
                      child: const Text(
                        'Forgot pin?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Add space above the button
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await context.read<AuthProvider>().signin(
                                email: usernameController.text,
                                password: passwordController.text,
                              );

                          var user = context.read<AuthProvider>().user;
                          print("You are logged in as ${user!.email}");
                          context.push('/home');
                        } on DioException catch (e) {
                          if (e.response == null) return;
                          if (e.response!.data == null) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.response!.data['message'] ??
                                  "Unexpected error"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFB8E36),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20), // Increase button size
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight
                                .bold), // Increase font size and make bold
                      ),
                      child: const Text('Sign In'),
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
