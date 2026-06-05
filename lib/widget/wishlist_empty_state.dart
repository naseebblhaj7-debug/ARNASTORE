import 'package:flutter/material.dart';

class WishlistEmptyState extends StatelessWidget {
  final Color brandGold;
  final Color darkText;

  const WishlistEmptyState({
    super.key,
    required this.brandGold,
    required this.darkText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: brandGold.withOpacity(0.15),
            ),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 80,
              color: brandGold,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "No Favorites Yet",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Start adding jewelry you love ❤️",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              color: brandGold,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: brandGold.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              "Explore Products",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
