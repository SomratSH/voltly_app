import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/application/host/profile/repo/host_profile_repo.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/profile/profile_provider.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';

class ChangePasswordHost extends StatelessWidget {
  const ChangePasswordHost({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HostProfileProvider()..getProfileHost(),
      child: const _Layout(),
    );
  }
}

class _Layout extends StatefulWidget {
  const _Layout({super.key});

  @override
  State<_Layout> createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  // ✅ Controllers persist between rebuilds
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HostProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121C24),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text("Voltly", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              vPad20,

              // Old password field
              _buildPasswordField(
                controller: _oldPasswordController,
                label: "Old Password",
                obscure: _obscureOld,
                onToggle: () => setState(() => _obscureOld = !_obscureOld),
              ),
              vPad15,

              // New password field
              _buildPasswordField(
                controller: _newPasswordController,
                label: "New Password",
                obscure: _obscureNew,
                onToggle: () => setState(() => _obscureNew = !_obscureNew),
              ),
              vPad15,

              // Confirm password field
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: "Confirm Password",
                obscure: _obscureConfirm,
                onToggle: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),

              vPad50,

              PrimaryButton(
                text: "Update",
                onPressed: () async {
                  final oldPassword = _oldPasswordController.text.trim();
                  final newPassword = _newPasswordController.text.trim();
                  final confirmPassword = _confirmPasswordController.text
                      .trim();

                  if (oldPassword.isEmpty ||
                      newPassword.isEmpty ||
                      confirmPassword.isEmpty) {
                    CustomSnackbar.show(
                      context,
                      message: "Please fill all fields",
                    );
                    return;
                  }
                  if (newPassword != confirmPassword) {
                    CustomSnackbar.show(
                      context,
                      message: "Passwords do not match",
                    );
                    return;
                  }

                  LoadingDialog.show(context);
                  final result = await provider.changePasswordHost(
                    oldPassword: oldPassword,
                    password: newPassword,
                    confirmPassword: confirmPassword,
                  );
                  LoadingDialog.hide(context);

                  if (result["messase"] != null) {
                    CustomSnackbar.show(
                      context,
                      message: "Password updated successfully",
                    );
                    context.go("/profile");
                  } else {
                    CustomSnackbar.show(
                      context,
                      message: result["message"] ?? "Something went wrong",
                      backgroundColor: Colors.red,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF4B5563)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey[400],
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
