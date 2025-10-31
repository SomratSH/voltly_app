import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';
import 'package:voltly_app/presentation/common_page/authentication/forgot_password.dart';
import 'package:voltly_app/presentation/common_page/authentication/signup_screen.dart';
import 'package:voltly_app/presentation/station_owner/landing_page/landing_owner_page.dart';
import 'package:voltly_app/presentation/user/landing_page/landing_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDriverSelected = true;
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Black Screen Placeholder
              Container(
                width: 276,
                height: 155,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://autovista24.autovistagroup.com/wp-content/uploads/sites/5/2021/09/GettyImages-1325838855-e1631019789721.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(41),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Voltly Title
              const Text(
                'Voltly',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                'EV Charging Marketplace',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),

              const SizedBox(height: 40),

              // Driver/Host Toggle Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDriverSelected = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isDriverSelected
                              ? const Color(0xFF007F5F)
                              : Color(0xFF374151),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.directions_car,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Driver',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDriverSelected = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: !_isDriverSelected
                              ? const Color(0xFF007F5F)
                              : const Color(0xFF374151),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.bolt,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Host',
                              style: TextStyle(
                                color: const Color(0xFFD1D5DB),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Email Input Field
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF374151)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email address',
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

              const SizedBox(height: 16),

              // Password Input Field
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF374151)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey[400],
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // OR Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey[600], thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey[600], thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Continue with Google Button
              Container(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Google sign in
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[600]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icon/google_icon.svg"),
                      const SizedBox(width: 12),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Continue with Apple Button
              Container(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Apple sign in
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[600]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icon/apple_icon.svg"),
                      const SizedBox(width: 12),
                      const Text(
                        'Continue with Apple',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Login Button
              PrimaryButton(
                text: "Login",
                onPressed: () async {
                  LoadingDialog.show(context);
                  final status = await provider.login(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  if (status['message'] != null) {
                    LoadingDialog.hide(context);
                    CustomSnackbar.show(
                      context,
                      message: status["message"],
                      textColor: Colors.white,
                    );
                    if (status["data"]["role"] == "Host") {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isHost', true);
                      await prefs.setBool('isDriver', false);
                      context.go(RouterPath.homeOwner);
                    } else if ((status["data"]["role"] == "User")) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isHost', false);
                      await prefs.setBool('isDriver', true);
                      context.go(RouterPath.home);
                    }
                  } else if (status["error"] != null) {
                    LoadingDialog.hide(context);
                    CustomSnackbar.show(
                      context,
                      message: status["error"][0],
                      backgroundColor: Colors.red,
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: InkWell(
                  onTap: () {
                    _isDriverSelected
                        ? context.go(RouterPath.singUp)
                        : context.go(RouterPath.hostSignUpStep1);
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.black.withValues(alpha: 0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color(0xFFE5E7EB),
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Forgot Password Link
              GestureDetector(
                onTap: () async {
                  context.push(RouterPath.forgotPassword);
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFF007F5F),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
