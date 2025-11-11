import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';


class ConnectSuccess extends StatelessWidget {
  const ConnectSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            vPad50,
            Text(
              'Successful Connect',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            vPad50,
            Lottie.asset('assets/image/success_check.json'),
            Text(
              'Successful!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.20,
              ),
            ),
            vPad20,
            Text(
              'Successfully made account connected to Strip ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF989898),
                fontSize: 18.26,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.40,
                letterSpacing: 0.23,
              ),
            ),
            vPad20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                text: "Back to home",
                onPressed: () {
                  context.go(RouterPath.home);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
