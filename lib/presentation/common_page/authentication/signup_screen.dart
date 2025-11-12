import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';

class VoltlyCreateAccountPage extends StatefulWidget {
  bool isDriver;
  VoltlyCreateAccountPage({super.key, required this.isDriver});

  @override
  _VoltlyCreateAccountPageState createState() =>
      _VoltlyCreateAccountPageState();
}

class _VoltlyCreateAccountPageState extends State<VoltlyCreateAccountPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = false;
  String _selectedCountryCode = '+1';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final List<String> _countryCodes = ['+1', '+44', '+91', '+86', '+49', '+33'];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                'Sign up to charge your EV anytime,\nanywhere',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 40),

              // Full Name Field
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.grey[400],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Email Field
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  controller: _emailController,
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

              const SizedBox(height: 16),

              // Phone Number Field with Country Code
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    // Phone Icon
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.phone_outlined,
                        color: Colors.grey[400],
                      ),
                    ),

                    // Country Code Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCountryCode,
                          dropdownColor: const Color(0xFF374151),
                          style: const TextStyle(color: Colors.white),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          items: _countryCodes.map((String code) {
                            return DropdownMenuItem<String>(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedCountryCode = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    // Phone Number Input
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Password Field
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
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

              const SizedBox(height: 16),

              // Confirm Password Field
              Container(
                decoration: ShapeDecoration(
                  color: Colors.black.withValues(alpha: 0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isConfirmPasswordVisible
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

              const SizedBox(height: 24),

              // Terms and Privacy Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFF4CAF50),
                    side: BorderSide(color: Colors.grey[600]!),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          children: [
                            const TextSpan(text: 'I agree to '),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: const TextStyle(
                                color: Color(0xFF007F5F),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' & '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: const Color(0xFF007F5F),
                                decoration: TextDecoration.underline,
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

              // Sign Up Button
              PrimaryButton(
                text: "Sign Up",
                onPressed: _agreeToTerms
                    ? () async {
                        if (_passwordController.text ==
                            _confirmPasswordController.text) {
                          LoadingDialog.show(context);
                          final reseponse = await provider.signUpDrver(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            role: widget.isDriver ? "user" : "host",
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                            isTerms: _agreeToTerms,
                          );

                          if (reseponse['message'] != null) {
                            LoadingDialog.hide(context);
                            CustomSnackbar.show(
                              context,
                              message: reseponse["message"],
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                            context.push("/login");
                          } else if (reseponse["email"] != null) {
                            LoadingDialog.hide(context);
                            CustomSnackbar.show(
                              context,
                              message: reseponse["email"][0],
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please agree to the terms to proceed',
                            ),
                            backgroundColor: Color(0xFF007F5F),
                          ),
                        );
                      },
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
                decoration: ShapeDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: const Color(0xFFE5E7EB),
                      width: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Google sign up
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
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Apple sign up
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

              // Already have an account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  Text(
                    ' Login',
                    style: TextStyle(
                      color: const Color(0xFF007F5F),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
