import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle titleWhite = TextStyle(
    color: AppColors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headerTitle = TextStyle(
    color: AppColors.darkText,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: "Cinzel",
    shadows: [
      Shadow(
        color: Color.fromARGB(255, 64, 54, 49),
        blurRadius: 8,
        offset: Offset(0, 1),
      ),
    ],
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  static const TextStyle linkText = TextStyle(
    color: AppColors.brandGold,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle productPrice = TextStyle(
    color: Color.fromARGB(255, 217, 199, 147),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle whiteTitle = TextStyle(
    color: AppColors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}
