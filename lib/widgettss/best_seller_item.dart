import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/snakbar.dart'; // استدعاء الكلاس الجديد

class BestSellerItem extends StatelessWidget {
  final String imgPath;
  final int price;
  final List<Map<String, dynamic>> favoriteItems;
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) onToggleFavorite;
  final Function(Map<String, dynamic>) onAddToCart;

  const BestSellerItem({
    super.key,
    required this.imgPath,
    required this.price,
    required this.favoriteItems,
    required this.cartItems,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imgPath,
              height: 260,
              width: 170,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 260,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  const Color.fromARGB(0, 236, 226, 226),
                ],
              ),
            ),
          ),

          /// ❤️ HEART ICON
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                onToggleFavorite({
                  "image": imgPath,
                  "title": "Luxury Jewelry",
                  "price": price,
                });
                AppSnackBar.show(
                  context,
                  message: favoriteItems.any((item) => item["image"] == imgPath)
                      ? " Added to favorites"
                      : "❌ Removed from favorites",
                  icon: Icons.favorite,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  favoriteItems.any((item) => item["image"] == imgPath)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 20,
                  color: favoriteItems.any((item) => item["image"] == imgPath)
                      ? Colors.red
                      : AppColors.brandGold,
                ),
              ),
            ),
          ),

          /// 🛒 CART ICON
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                onAddToCart({
                  "image": imgPath,
                  "title": "Luxury Jewelry",
                  "price": price,
                  "quantity": 1,
                });
                AppSnackBar.show(
                  context,
                  message: "🛒 Added to cart successfully",
                  icon: Icons.check_circle,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.brandGold,
                ),
              ),
            ),
          ),

          /// العنوان + السعر
          Positioned(
            bottom: 12,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Luxury Jewelry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("\$$price", style: AppTextStyles.productPrice),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
