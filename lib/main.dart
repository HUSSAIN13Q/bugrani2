import 'package:bugrani2/pages/CommunityPage.dart';
import 'package:bugrani2/pages/HomePage.dart';
import 'package:bugrani2/providers/clubs_provider.dart';
import 'package:bugrani2/providers/inbox_provider.dart';
import 'package:bugrani2/providers/leaves_provider.dart';
import 'package:bugrani2/providers/meetings_provider.dart';
import 'package:bugrani2/providers/search_provider.dart';
import 'package:bugrani2/providers/workshop_provider.dart';
import 'package:bugrani2/sign_in/forget_pass.dart';
import 'package:bugrani2/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'sign_in/auth_provider.dart';
import 'providers/attendance_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LeavesProvider()),
        ChangeNotifierProvider(create: (_) => WorkshopProvider()),
        ChangeNotifierProvider(create: (_) => ClubsProvider()),
        ChangeNotifierProvider(create: (_) => MyWorkshopProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => MeetingProvider())
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
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
