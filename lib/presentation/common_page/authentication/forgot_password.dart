import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';
import 'package:voltly_app/presentation/common_page/authentication/verify_email.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.20,
              ),
            ),
            Text(
              'Sign up to charge your EV anytime, anywhere',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.62,
              ),
            ),
            const SizedBox(height: 55),
            Container(
              decoration: ShapeDecoration(
                color: Colors.black.withValues(alpha: 0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.grey[400],
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: "Recover Account",
              onPressed: () async {
                LoadingDialog.show(context);
                final status = await provider.sendOtp(
                  email: emailController.text,
                );
                if (status["message"] != null) {
                  LoadingDialog.hide(context);
                  CustomSnackbar.show(
                    context,
                    message: status["message"],
                    backgroundColor: Colors.green,
                  );
                  context.push(
                    RouterPath.verifyOtp,
                    extra: emailController.text,
                  );
                } else if (status["errors"] != null) {
                  LoadingDialog.hide(context);
                  CustomSnackbar.show(
                    context,
                    message: status["errors"],
                    backgroundColor: Colors.red,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
