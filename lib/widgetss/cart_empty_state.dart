import 'package:flutter/material.dart';

class CartEmptyState extends StatelessWidget {
  final Color brandGold;
  final Color darkText;

  const CartEmptyState({
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
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  brandGold.withOpacity(0.25),
                  brandGold.withOpacity(0.08),
                ],
              ),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 85,
              color: brandGold,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            "Your Cart Is Empty",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkText,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Looks like you haven't added anything yet. Start shopping your favorite jewelry now.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                height: 1.6,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 35),
          Container(
            height: 55,
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [brandGold, const Color(0xFFD8C08A)],
              ),
              boxShadow: [
                BoxShadow(
                  color: brandGold.withOpacity(0.35),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Start Shopping",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
