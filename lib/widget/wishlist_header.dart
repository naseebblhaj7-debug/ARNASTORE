import 'package:flutter/material.dart';

class WishlistHeader extends StatelessWidget {
  final int itemCount;
  final Color brandGold;
  final Color darkText;

  const WishlistHeader({
    super.key,
    required this.itemCount,
    required this.brandGold,
    required this.darkText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$itemCount Items",
            style: TextStyle(
              color: darkText,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: brandGold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "Luxury Collection",
              style: TextStyle(
                color: brandGold,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
