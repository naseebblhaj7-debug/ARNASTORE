import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;

  const ServiceIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 235, 232, 221),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 218, 199, 153),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.brandGold, size: 28),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 33, 30, 20),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          sub,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
