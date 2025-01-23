import 'package:bugrani2/pages/CommunityPage.dart';
import 'package:bugrani2/pages/home_page.dart';
import 'package:bugrani2/providers/clubs_provider.dart';
import 'package:bugrani2/providers/leaves_provider.dart';
import 'package:bugrani2/providers/workshop_provider.dart';
import 'package:bugrani2/sign_in/forget_pass.dart';
import 'package:bugrani2/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LeavesProvider()),
        ChangeNotifierProvider(create: (_) => WorkshopProvider()),
        ChangeNotifierProvider(create: (_) => ClubsProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider())
      ],
      child: const MainApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/forget_pass',
      builder: (context, state) => const ForgetPassPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(), // Route to HomePage
    ),
    // GoRoute(
    //   path: '/leaves_page',
    //   builder: (context, state) => LeavesPage(), // Route to LeavesPage
    // ),
    // Add other routes here as needed
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    );
  }
}
