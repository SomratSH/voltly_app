import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voltly_app/common/custom_dialog.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/presentation/user/profile/changed_password.dart';
import 'package:voltly_app/presentation/user/profile/charging_history.dart';
import 'package:voltly_app/presentation/user/profile/message_page.dart';
import 'package:voltly_app/presentation/user/profile/privacy_policy.dart';
import 'package:voltly_app/presentation/user/profile/terms_condition.dart';
import 'package:voltly_app/presentation/user/profile/update_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Voltly',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.20,
                ),
              ),
              const SizedBox(height: 16),
              _buildUserInfoCard(),
              const SizedBox(height: 24),
              _buildMenuSection(context),
              const SizedBox(height: 24),
              _buildSettingsAndSupportSection(context),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => showLogoutDialog(context),
                child: _buildFooter(),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFF01CC01),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNV2dimRVLDjbd9FtA7z4Qz8wJIVQ_UljnUiB6Zd-5TCWz8-5TFzTZf90&s',
                ), // Placeholder
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rafsan Mahmud',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.42,
                  letterSpacing: 0.24,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'rafsan@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.83,
                  letterSpacing: 0.12,
                ),
              ),
              Text(
                '+555 1234567',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.83,
                  letterSpacing: 0.12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),

      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UpdateProfile()),
              );
            },
            child: _buildMenuItem(
              "assets/icon/user _pp.svg",
              'Account Profile',
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChargingHistory()),
            ),
            child: _buildMenuItem(
              "assets/icon/card-pos.svg",
              'Charging History',
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChangedPassword()),
            ),
            child: _buildMenuItem("assets/icon/key.svg", 'Change Password'),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MessagesScreen()),
            ),
            child: _buildMenuItem(
              "assets/icon/message-text.svg",
              'Messages',
              showDivider: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsAndSupportSection(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: const Color(0xFF182724),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings & Support',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSwitchItem(Icons.notifications_none, 'Notifications'),

                _buildMenuItemIcon(
                  Icons.help_outline,
                  'Help Center',
                  showDivider: false,
                ),

                InkWell(
                  onTap: () => showAccountDeleteDialog(context),
                  child: const Text(
                    'Delete Account !',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TermsScreen()),
                      ),
                      child: Text(
                        'Terms & Conditions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    vPad10,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PrivacyPolicy()),
                        );
                      },
                      child: Text(
                        'Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: const Color(0xFF01CC01)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Center(
            child: Text(
              'Logout',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF01CC01),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.38,
                letterSpacing: 0.16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildMenuItem(
    String icon,
    String title, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              if (icon != null) ...[
                DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFADAEBC),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(icon),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFFADAEBC),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.38,
                  letterSpacing: 0.16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildMenuItemIcon(
    IconData? icon,
    String title, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 16),
              ],
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildSwitchItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 16),
              Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ],
          ),
          Switch(
            value: true,
            onChanged: (bool value) {},
            activeColor: const Color(0xFF33D933),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.white10,
          ),
        ],
      ),
    );
  }
}
