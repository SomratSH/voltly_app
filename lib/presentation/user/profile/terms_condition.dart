import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/application/host/profile/model/host_profile_model.dart';
import 'package:voltly_app/common/custom_html_text.dart';
import 'package:voltly_app/presentation/station_owner/profile/profile_provider.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final proivder = context.watch<HostProfileProvider>();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Terms & Condition",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${toPlainText(proivder.termConditionModel.content!)}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Expanded(
                  child: Text(
                    "I agree to Terms & Conditions & Privacy Policy",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
