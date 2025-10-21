import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/presentation/common_page/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    if (prefs.getString('authToken') != null &&
        prefs.getString('authToken')!.isNotEmpty) {
      if (prefs.getBool('isDriver') == true &&
          prefs.getBool('isHost') == false) {
        context.go(RouterPath.home);
      } else if (prefs.getBool('isDriver') == false &&
          prefs.getBool('isHost') == true) {
        context.go(RouterPath.homeOwner);
      }
    } else {
      context.go(RouterPath.onBoardingOne);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset("assets/image/Voltz.json")),
    );
  }
}
