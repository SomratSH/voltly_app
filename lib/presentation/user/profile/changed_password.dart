import 'package:flutter/material.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';

class ChangedPassword extends StatelessWidget {
  const ChangedPassword({super.key});

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
        title: Text("Voltly", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.20,
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
                obscureText: false,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Old Password',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.grey[400],
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            vPad15,
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
                obscureText: false,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'New Password',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.grey[400],
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            vPad15,
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
                obscureText: false,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.grey[400],
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            vPad70,
            PrimaryButton(
              text: "Update",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
