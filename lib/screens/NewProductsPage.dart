import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_text_styles.dart';
import 'package:appr/widgets/app_bar.dart';
import 'package:appr/widgets/snakbar.dart'; // استدعاء الكلاس الجديد

class NewProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> favoriteItems;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onToggleFavorite;

  const NewProductsPage({
    super.key,
    required this.cartItems,
    required this.favoriteItems,
    required this.onAddToCart,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "New Product",
        showBack: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("products")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!.docs.map((doc) {
            return doc.data() as Map<String, dynamic>;
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              final category = (product["category"] ?? "").toLowerCase();

              String imagePath = "images/placeholder.png";
              if (category == "rings") {
                imagePath = "images/r1.jpg";
              } else if (category == "earrings") {
                imagePath = "images/e1.jpg";
              } else if (category == "necklace") {
                imagePath = "images/n1.webp";
              } else if (category == "bracelet") {
                imagePath = "images/b1.webp";
              }

              final item = {
                "title": product["title"] ?? "",
                "price": product["price"] ?? "0",
                "image": imagePath,
                "quantity": 1,
              };

              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    /// زر الفيفورت ❤️
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          onToggleFavorite(item);
                          AppSnackBar.show(
                            context,
                            message: favoriteItems.contains(item)
                                ? "❤️ Added to favorites"
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
                            favoriteItems.contains(item)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color: favoriteItems.contains(item)
                                ? Colors.red
                                : const Color(0xFFCAB273),
                          ),
                        ),
                      ),
                    ),

                    /// زر السلة 🛒
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          onAddToCart(item);
                          AppSnackBar.show(
                            context,
                            message: "🛒 Product added to cart",
                            icon: Icons.shopping_cart,
                          );
                          Navigator.of(context).pushNamed("cartpage");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Color(0xFFCAB273),
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
                          Text(
                            product["title"] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${product["price"]} \$",
                            style: AppTextStyles.productPrice,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
