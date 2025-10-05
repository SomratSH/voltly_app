import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/common_page/onboarding/splash_screen.dart';
import 'package:voltly_app/presentation/station_owner/landing_page/landing_owner_page.dart';
import 'package:voltly_app/presentation/user/landing_page/landing_page.dart';
import 'package:voltly_app/presentation/user/station/add_charing.dart';
import 'package:voltly_app/presentation/user/station/connect_charger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0B1A24),
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF0B1A24)),
      ),
      home: SplashScreen(),
    );
  }
}
