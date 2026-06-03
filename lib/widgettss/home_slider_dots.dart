import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeSliderDots extends StatelessWidget {
  final int currentPage;
  final int imagesLength;

  const HomeSliderDots({
    super.key,
    required this.currentPage,
    required this.imagesLength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imagesLength,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.brandGold
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
