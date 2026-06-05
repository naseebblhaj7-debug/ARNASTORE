import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';
import 'package:appr/screens/NewProductsPage.dart';

class AppHeader extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> favoriteItems;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onToggleFavorite;

  const AppHeader({
    super.key,
    required this.cartItems,
    required this.favoriteItems,
    required this.onAddToCart,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset("images/logo.png", width: 90, height: 90),
              const SizedBox(width: 6),
              Text("ARNA JEWELRY", style: AppTextStyles.headerTitle),
            ],
          ),

          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewProductsPage(
                        cartItems: cartItems,
                        favoriteItems: favoriteItems,
                        onAddToCart: onAddToCart,
                        onToggleFavorite: onToggleFavorite,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Color(0xFFCAB273),
                    size: 30,
                  ),
                ),
              ),

              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCAB273),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Text(
                    "NEW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
