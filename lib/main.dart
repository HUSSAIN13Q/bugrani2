import 'package:bugrani2/pages/home_page.dart';
import 'package:bugrani2/pages/leaves_page.dart';
import 'package:bugrani2/sign_in/forget_pass.dart';
import 'package:bugrani2/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'sign_in/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LeavesPage(),
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
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
