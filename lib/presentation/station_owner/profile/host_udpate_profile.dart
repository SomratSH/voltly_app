import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/app_router.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_urls.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';
import 'package:voltly_app/presentation/user/profile/profile_provider.dart';

class HostUpdateProfile extends StatelessWidget {
  const HostUpdateProfile({super.key});

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
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // Persistent controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F2937),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text(
                  "Take Photo",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (picked != null) {
                    setState(() => _selectedImage = File(picked.path));
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.white),
                title: const Text(
                  "Choose from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (picked != null) {
                    setState(() => _selectedImage = File(picked.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<HostProfileProvider>();
    final profile = profileProvider.hostProfileModel.data;

    // Initialize controllers when profile loads (only once)
    if (profile != null && _nameController.text.isEmpty) {
      _nameController.text = profile.fullName ?? '';
      _phoneController.text = profile.phone ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go(RouterPath.profileHost),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "Account Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    vPad20,
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : NetworkImage(
                                        profile.picture == null
                                            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR92SteKCmoJpBh3GlakGipEznqeWRH2NyfpA&s"
                                            : "${AppUrls.imageUrl}${profile.picture}",
                                      )
                                      as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    vPad5,
                    const Text(
                      'Change profile photo',
                      style: TextStyle(
                        color: Color(0xFFADAEBC),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    vPad20,

                    // Full Name Field
                    _buildTextField(
                      controller: _nameController,
                      icon: Icons.person_outline,
                      hint: 'Full Name',
                      onChanged: profileProvider.updateNameHost,
                    ),
                    vPad10,

                    // Phone Field
                    _buildTextField(
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                      hint: 'Phone Number',
                      onChanged: profileProvider.updatePhoneHost,
                      keyboardType: TextInputType.phone,
                    ),
                    vPad20,

                    // Update Button
                    PrimaryButton(
                      text: "Update",
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        LoadingDialog.show(context);
                        final status = await profileProvider.updateProfileHost(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          image: _selectedImage,
                        );
                        LoadingDialog.hide(context);

                        if (status["message"] ==
                            "Profile updated successfully.") {
                          CustomSnackbar.show(
                            context,
                            message: status["message"],
                          );
                        } else {
                          CustomSnackbar.show(
                            context,
                            message: "Something went wrong. Try again.",
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                    ),
                    vPad20,
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
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
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
