import 'package:flutter/material.dart';

class ProfileStat extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap; // 👈 أضفنا هنا

  const ProfileStat({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // 👈 يعطي تأثير الضغط (ripple effect)
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.95),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
