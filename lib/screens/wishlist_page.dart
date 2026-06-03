import 'package:flutter/material.dart';
import '../widget/wishlist_empty_state.dart';
import '../widget/wishlist_header.dart';
import '../widget/wishlist_item_card.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteItems;
  final Function(Map<String, dynamic>) removeItem;
  final Function(Map<String, dynamic>) addToCart;

  const WishlistPage({
    super.key,
    required this.favoriteItems,
    required this.removeItem,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    final Color brandGold = const Color(0xFFCAB273);
    final Color darkText = const Color(0xFF31231C);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EE),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF8F5EE),
        title: Text(
          "My Wishlist",
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: favoriteItems.isEmpty
          ? WishlistEmptyState(brandGold: brandGold, darkText: darkText)
          : Column(
              children: [
                WishlistHeader(
                  itemCount: favoriteItems.length,
                  brandGold: brandGold,
                  darkText: darkText,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: favoriteItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      childAspectRatio: 0.67,
                    ),
                    itemBuilder: (context, index) {
                      final product = favoriteItems[index];
                      return WishlistItemCard(
                        product: product,
                        brandGold: brandGold,
                        darkText: darkText,
                        onRemove: () => removeItem(product),
                        onAddToCart: () {
                          addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: brandGold,
                              content: Text(
                                "${product["title"] ?? "Item"} added to cart 🛒",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
