import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';

class HostSignUpStep1 extends StatelessWidget {
  final bool isDriver;
  const HostSignUpStep1({super.key, required this.isDriver});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final countryCodes = ['+1', '+44', '+91', '+86', '+49', '+33'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to charge your EV anytime,\nanywhere',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),

              // Full Name
              _buildInputField(
                hint: 'Full Name',
                icon: Icons.person_outline,
                onChanged: provider.updateName,
              ),
              const SizedBox(height: 16),

              // Email
              _buildInputField(
                hint: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: provider.updateEmail,
              ),
              const SizedBox(height: 16),

              // Phone
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.phone_outlined, color: Colors.grey),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: provider.selectedCountryCode,
                          dropdownColor: const Color(0xFF374151),
                          style: const TextStyle(color: Colors.white),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          items: countryCodes.map((String code) {
                            return DropdownMenuItem<String>(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              provider.updateCountryCode(value);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        onChanged: provider.updatePhone,
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

              // Password
              _buildPasswordField(
                hint: 'Password',
                onChanged: provider.updatePassword,
              ),
              const SizedBox(height: 16),

              // Confirm Password
              _buildPasswordField(
                hint: 'Confirm Password',
                onChanged: provider.updateConfirmPassword,
              ),
              const SizedBox(height: 24),

              // Terms
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: provider.agreeToTerms,
                    onChanged: (v) => provider.toggleAgreeToTerms(v ?? false),
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
                          children: const [
                            TextSpan(text: 'I agree to '),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                color: Color(0xFF007F5F),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: ' & '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF007F5F),
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
                text: "Next",
                onPressed: provider.agreeToTerms
                    ? () async {
                        if (provider.password == provider.confirmPassword) {
                          context.go(RouterPath.hostStringUpStep2);
                        } else {
                          CustomSnackbar.show(
                            context,
                            message: "Passwords do not match",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      }
                    : () {
                        CustomSnackbar.show(
                          context,
                          message: "Please agree to the terms to proceed",
                          backgroundColor: const Color(0xFF007F5F),
                          textColor: Colors.white,
                        );
                      },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String hint,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: TextField(
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:voltly_app/app_router.dart';
// import 'package:voltly_app/common/custom_loading_dialog.dart';
// import 'package:voltly_app/common/custom_sanckbar.dart';
// import 'package:voltly_app/common/primary_button.dart';
// import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';

// class HostSignUpStep1 extends StatelessWidget {
//   final bool isDriver;
//   const HostSignUpStep1({super.key, required this.isDriver});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<AuthProvider>();
//     final countryCodes = ['+1', '+44', '+91', '+86', '+49', '+33'];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF121C24),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => context.pop(),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Create Account',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Sign up to charge your EV anytime,\nanywhere',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[400],
//                   height: 1.4,
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Full Name
//               _buildInputField(
//                 hint: 'Full Name',
//                 icon: Icons.person_outline,
//                 onChanged: provider.updateName,
//               ),
//               const SizedBox(height: 16),

//               // Email
//               _buildInputField(
//                 hint: 'Email',
//                 icon: Icons.email_outlined,
//                 keyboardType: TextInputType.emailAddress,
//                 onChanged: provider.updateEmail,
//               ),
//               const SizedBox(height: 16),

//               // Phone
//               Container(
//                 decoration: ShapeDecoration(
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Icon(Icons.phone_outlined, color: Colors.grey),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           value: provider.selectedCountryCode,
//                           dropdownColor: const Color(0xFF374151),
//                           style: const TextStyle(color: Colors.white),
//                           icon: const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: Colors.grey,
//                           ),
//                           items: countryCodes.map((String code) {
//                             return DropdownMenuItem<String>(
//                               value: code,
//                               child: Text(code),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             if (value != null) {
//                               provider.updateCountryCode(value);
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         style: const TextStyle(color: Colors.white),
//                         keyboardType: TextInputType.phone,
//                         onChanged: provider.updatePhone,
//                         decoration: InputDecoration(
//                           hintText: 'Phone Number',
//                           hintStyle: TextStyle(color: Colors.grey[400]),
//                           border: InputBorder.none,
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 16,
//                             horizontal: 8,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Password
//               _buildPasswordField(
//                 hint: 'Password',
//                 onChanged: provider.updatePassword,
//               ),
//               const SizedBox(height: 16),

//               // Confirm Password
//               _buildPasswordField(
//                 hint: 'Confirm Password',
//                 onChanged: provider.updateConfirmPassword,
//               ),
//               const SizedBox(height: 24),

//               // Terms
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Checkbox(
//                     value: provider.agreeToTerms,
//                     onChanged: (v) => provider.toggleAgreeToTerms(v ?? false),
//                     activeColor: const Color(0xFF4CAF50),
//                     side: BorderSide(color: Colors.grey[600]!),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 12),
//                       child: RichText(
//                         text: TextSpan(
//                           style: TextStyle(
//                             color: Colors.grey[400],
//                             fontSize: 14,
//                           ),
//                           children: const [
//                             TextSpan(text: 'I agree to '),
//                             TextSpan(
//                               text: 'Terms & Conditions',
//                               style: TextStyle(
//                                 color: Color(0xFF007F5F),
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                             TextSpan(text: ' & '),
//                             TextSpan(
//                               text: 'Privacy Policy',
//                               style: TextStyle(
//                                 color: Color(0xFF007F5F),
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),

//               // Sign Up Button
//               PrimaryButton(
//                 text: "Next",
//                 onPressed: provider.agreeToTerms
//                     ? () async {
//                         if (provider.password == provider.confirmPassword) {
//                           context.go(RouterPath.hostStringUpStep2);
//                         } else {
//                           CustomSnackbar.show(
//                             context,
//                             message: "Passwords do not match",
//                             backgroundColor: Colors.red,
//                             textColor: Colors.white,
//                           );
//                         }
//                       }
//                     : () {
//                         CustomSnackbar.show(
//                           context,
//                           message: "Please agree to the terms to proceed",
//                           backgroundColor: const Color(0xFF007F5F),
//                           textColor: Colors.white,
//                         );
//                       },
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required String hint,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     required Function(String) onChanged,
//   }) {
//     return Container(
//       decoration: ShapeDecoration(
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: TextField(
//         style: const TextStyle(color: Colors.white),
//         keyboardType: keyboardType,
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey[400]),
//           prefixIcon: Icon(icon, color: Colors.grey[400]),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.all(16),
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField({
//     required String hint,
//     required Function(String) onChanged,
//   }) {
//     return Container(
//       decoration: ShapeDecoration(
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: TextField(
//         obscureText: true,
//         style: const TextStyle(color: Colors.white),
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey[400]),
//           prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.all(16),
//         ),
//       ),
//     );
//   }
// }
