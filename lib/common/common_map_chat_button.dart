import 'package:flutter/material.dart';

class MapChatButtons extends StatelessWidget {
  final VoidCallback onTapMap;
  final VoidCallback onTapMessage;

  const MapChatButtons({
    super.key,
    required this.onTapMap,
    required this.onTapMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _CustomActionButton(
            icon: Icons.near_me_outlined,
            label: "Go To Map",
            onTap: onTapMap, // ✅ pass reference, don’t call it
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _CustomActionButton(
            icon: Icons.chat_bubble_outline,
            label: "Chat With Us",
            onTap: onTapMessage, // ✅ pass reference, don’t call it
          ),
        ),
      ],
    );
  }
}

class _CustomActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CustomActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0E1B24),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.tealAccent.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.tealAccent.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.tealAccent, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.tealAccent,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
