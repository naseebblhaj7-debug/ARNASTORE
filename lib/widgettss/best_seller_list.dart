import 'package:flutter/material.dart';
import 'best_seller_item.dart';

class BestSellerList extends StatelessWidget {
  final List<String> bestSellers;
  final List<int> prices;
  final List<Map<String, dynamic>> favoriteItems;
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) onToggleFavorite;
  final Function(Map<String, dynamic>) onAddToCart;

  const BestSellerList({
    super.key,
    required this.bestSellers,
    required this.prices,
    required this.favoriteItems,
    required this.cartItems,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: bestSellers.length,
        itemBuilder: (context, index) => BestSellerItem(
          imgPath: bestSellers[index],
          price: prices[index],
          favoriteItems: favoriteItems,
          cartItems: cartItems,
          onToggleFavorite: onToggleFavorite,
          onAddToCart: onAddToCart,
        ),
      ),
    );
  }
}
