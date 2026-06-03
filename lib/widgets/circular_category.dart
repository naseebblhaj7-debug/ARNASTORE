import 'package:flutter/material.dart';

class CircularCategory extends StatelessWidget {
  final String label;
  final String imagePath;

  const CircularCategory({
    super.key,
    required this.label,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFCAB273), // 👈 الحافة الذهبية
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFCAB273).withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 35, // 👈 أكبر شوي باش يبان أوضح
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF31231C),
          ),
        ),
      ],
    );
  }
}
