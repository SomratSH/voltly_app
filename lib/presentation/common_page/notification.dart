import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildNotificationCard(
              title: 'Your reservation is confirmed!',
              message:
                  'Your reservation for the Tesla Wall Connector at 123 Oak St is confirmed for Sep 16, 2025 at 9:00 AM.',
              timestamp: '2 hours ago',
              icon: Icons.check_circle_outline,
              iconColor: const Color(0xFF6AB04A),
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              title: 'Payout sent',
              message:
                  'Your recent earnings of \$42.00 have been successfully sent to your Stripe account.',
              timestamp: '1 day ago',
              icon: Icons.monetization_on_outlined,
              iconColor: const Color(0xFF6AB04A),
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              title: 'New charger added',
              message:
                  'Your new Level 2 Charger listing has been approved and is now live.',
              timestamp: '3 days ago',
              icon: Icons.electric_car,
              iconColor: const Color(0xFF6AB04A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String timestamp,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF182724),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            timestamp,
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
        ],
      ),
    );
  }
}
