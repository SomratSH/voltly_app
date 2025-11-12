import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';

import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_urls.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendReport() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "subject": _subjectController.text.trim(),
        "message": _messageController.text.trim(),
      };
      SharedPreferences preferences = await SharedPreferences.getInstance();
      LoadingDialog.show(context);
      final response = await ApiService().postDataRegular(
        AppUrls.helpSupport,
        data,
        authToken: preferences.getString("authToken"),
      );

      if (response["message"] != null) {
        LoadingDialog.hide(context);
        CustomSnackbar.show(
          context,
          message: response["message"],
          icon: Icons.check_circle_outline,
          backgroundColor: Colors.green,
        );
      } else {
        LoadingDialog.hide(context);
        CustomSnackbar.show(context, message: response['error']);
      }

      // TODO: Send this data to API or backend
      print("User report data: $data");

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,

        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "We’re here to help!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Please describe your issue and our team will get back to you shortly.",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Name
              const Text(
                "Full Name",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              CustomTex(
                controller: _nameController,
                hintText: "Enter your name",
                validator: (value) =>
                    value == null || value.isEmpty ? "Name is required" : null,
              ),
              const SizedBox(height: 16),

              // Email
              const Text(
                "Email Address",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: "example@email.com",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Subject
              const Text(
                "Subject",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _subjectController,
                hintText: "Issue with Charging Station",
                validator: (value) => value == null || value.isEmpty
                    ? "Subject is required"
                    : null,
              ),
              const SizedBox(height: 16),

              // Message
              const Text(
                "Message",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Describe your issue here...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFEDF1F3),
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Message cannot be empty"
                    : null,
              ),
              const SizedBox(height: 24),

              // Send button
              PrimaryButton(text: "Send", onPressed: _sendReport),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final IconData? prefixIcon;
  final int maxLines;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey[600], size: 22)
            : null,
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEDF1F3), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEDF1F3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
      ),
    );
  }
}

class CustomTex extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;

  const CustomTex({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEDF1F3), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEDF1F3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
        ),
      ),
    );
  }
}
