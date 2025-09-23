import 'package:flutter/material.dart';
import 'package:voltly_app/presentation/common_page/onboarding/splash_screen.dart';
import 'package:voltly_app/presentation/user/landing_page/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF121C24),
        fontFamily: 'Roboto',
      ),
      home: LandingPage(),
    );
  }
}
