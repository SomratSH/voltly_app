import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_html_text.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HostProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Voltly", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Clause 1
                    Text(
                      toPlainText(provider.privacyModel.content!),
                      style: TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
