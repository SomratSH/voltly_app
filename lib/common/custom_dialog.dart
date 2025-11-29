import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';
import 'package:voltly_app/presentation/common_page/authentication/login_screen.dart';

Future<void> showLogoutDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      final provider = context.watch<AuthProvider>();
      return Dialog(
        backgroundColor: Color(0xFF121C24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logout Account",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Message
              Text(
                "Are you sure want to logout your Voltly account?",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 20),

              // Confirm Button
              PrimaryButton(
                text: "Confirm",
                onPressed: () async {
                  await provider.logout();
                  context.go("/login");
                  CustomSnackbar.show(context, message: "Logout Successfully");
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

class SharedPreferences {}

Future<void> showAccountDeleteDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button or close
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFF121C24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delete Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFC20000),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.70,
                      letterSpacing: 0.20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Message
              Text(
                'Are you sure want to Delete your Voltly account?',
                style: TextStyle(
                  color: Color(0xFFF9F9F9),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.70,
                  letterSpacing: 0.20,
                ),
              ),
              SizedBox(height: 20),

              // Confirm Button
              PrimaryButton(
                text: "Confirm",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
