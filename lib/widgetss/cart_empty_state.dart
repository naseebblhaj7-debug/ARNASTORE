import 'package:flutter/material.dart';
import 'package:appr/widgets/custom_button.dart'; // 👈 استدعاء الكوستوم بوتون

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
          // الأيقونة داخل دائرة
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

          // العنوان
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

          // الرسالة
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

          // زر باستخدام CustomButton
          CustomButton(
            text: "Start Shopping",
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: brandGold,
            textColor: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            width: 220,
            height: 55,
            borderRadius: 18,
            elevation: 0,
          ),
        ],
      ),
    );
  }
}
