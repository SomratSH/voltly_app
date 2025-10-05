import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/common_page/authentication/login_screen.dart';

class OnboardingScreenSecond extends StatelessWidget {
  const OnboardingScreenSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B1A24),
      body: SafeArea(
        child: Column(
          children: [
            // Car Image Section
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                color: Color(0xFF0B1A24),

                child: Center(
                  child: Image.asset(
                    "assets/image/new_image.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            // Main Content Section
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: const Color(0xFF121C24),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Voltly Title
                      SvgPicture.asset("assets/icon/splash_logo.svg"),

                      const SizedBox(height: 40),

                      // Main Tagline
                      const Text(
                        'Find.Charge.Go.',
                        style: TextStyle(
                          color: Color(0xFFF6F6F6),
                          fontSize: 28,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Description Text
                      Text(
                        'Book charging slots instantly. Pay\nsecurely. Drive without worry.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0x7FFBF9E0),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const Spacer(),

                      // Let's Go Button
                      PrimaryButton(
                        text: "Let's Go",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
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
