import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/presentation/common_page/authentication/auth_provider.dart';
import 'package:voltly_app/common/custom_loading_dialog.dart';
import 'package:voltly_app/common/custom_sanckbar.dart';

class HostSignUpStep2 extends StatelessWidget {
  HostSignUpStep2({super.key});

  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Station Information',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Step 2: Station Details",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter your EV station’s location and details below",
                  style: TextStyle(color: Colors.grey[400], fontSize: 15),
                ),
                const SizedBox(height: 32),

                // Station Name
                _buildInputField(
                  hint: "Station Name",
                  icon: Icons.ev_station,
                  onChanged: provider.setStationName,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Enter station name" : null,
                ),
                const SizedBox(height: 16),

                // Location Area
                _buildInputField(
                  hint: "Location Area",
                  icon: Icons.location_on_outlined,
                  onChanged: provider.setLocationArea,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Enter location area" : null,
                ),
                const SizedBox(height: 16),

                // Latitude
                _buildInputField(
                  hint: "Latitude",
                  icon: Icons.map,
                  keyboardType: TextInputType.number,
                  onChanged: provider.setLatitude,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Enter latitude" : null,
                ),
                const SizedBox(height: 16),

                // Longitude
                _buildInputField(
                  hint: "Longitude",
                  icon: Icons.map_outlined,
                  keyboardType: TextInputType.number,
                  onChanged: provider.setLongitude,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Enter longitude" : null,
                ),
                const SizedBox(height: 32),

                // Image Upload Section
                Text(
                  "Upload Station Image",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // If image selected → Show preview
                      provider.selectedImage != null
                          ? Column(
                              children: [
                                Image.file(
                                  provider.selectedImage!,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: provider.removeImage,
                                  child: const Text(
                                    "Remove Image",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              "No image selected",
                              style: TextStyle(color: Colors.white70),
                            ),

                      const SizedBox(height: 12),

                      // Upload Button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A9D8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.upload, color: Colors.white),
                        label: const Text(
                          "Upload Image",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _showImagePickerSheet(context, provider);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007F5F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        LoadingDialog.show(context);

                        final response = await provider.signUpHost(
                          name: provider.name,
                          email: provider.email,
                          phone: provider.phone,
                          role: "host",
                          password: provider.password,
                          confirmPassword: provider.confirmPassword,
                          isTerms: provider.agreeToTerms,
                          image: provider.selectedImage!,
                        );

                        LoadingDialog.hide(context);

                        if (response['message'] != null) {
                          CustomSnackbar.show(
                            context,
                            message: response["message"],
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                          context.push("/login");
                        } else if (response["email"] != null) {
                          CustomSnackbar.show(
                            context,
                            message: response["email"][0],
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Reusable styled field
  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
    required String? Function(String?) validator,
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
      child: TextFormField(
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

void _showImagePickerSheet(BuildContext context, AuthProvider provider) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.white),
              title: const Text(
                "Pick from Gallery",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                provider.pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text(
                "Take a Photo",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                provider.pickImageFromCamera();
              },
            ),
          ],
        ),
      );
    },
  );
}
