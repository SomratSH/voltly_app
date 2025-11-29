import 'package:flutter/material.dart';
import 'package:voltly_app/constant/app_colors.dart';

class EvStationCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final String rating;
  final VoidCallback onTap;

  const EvStationCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF121C24),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: hostprimaryColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  iconPath,
                  width: 40,
                  height: 40,
                  // color: primaryColor,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint("❌ Image station: $error");
                    return Image.network(
                      'https://www.directmobilityonline.co.uk/assets/img/noimage.png',
                      fit: BoxFit.cover,
                      width: 28,
                      height: 28,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),

            // 🔹 Info section (takes remaining space)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Station name (with ellipsis)
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFD1D5DB),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Subtitle, time, and rating row
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        color: Color(0xFFD1D5DB),
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFD1D5DB),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                      const SizedBox(width: 2),
                      Text(
                        rating,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // 🔹 Arrow icon
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFD1D5DB),
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
