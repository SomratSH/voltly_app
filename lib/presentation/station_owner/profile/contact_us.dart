import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          'Help Center',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.20,
              ),
            ),
            vPad50,
            Container(
              decoration: ShapeDecoration(
                color: Colors.black.withValues(alpha: 0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextField(
                controller: TextEditingController(),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'support@vultly.com',
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
            vPad20,
            Container(
              decoration: ShapeDecoration(
                color: Colors.black.withValues(alpha: 0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: const Color(0xFF4B5563)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextField(
                controller: TextEditingController(),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: '+555 12345678',
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
            vPad20,
            PrimaryButton(text: "Submit", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
