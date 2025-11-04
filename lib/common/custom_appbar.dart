import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltly_app/presentation/common_page/notification.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;
  final String notificationIconPath;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    this.logoPath = "assets/icon/logo.svg",
    this.notificationIconPath = "assets/icon/ph_bell.svg",
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: SvgPicture.asset(
        logoPath,
        width: 20,
        height: 20,
        fit: BoxFit.scaleDown,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationScreen()),
              );
            },
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(notificationIconPath),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
