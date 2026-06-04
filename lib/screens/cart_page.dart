import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_screen.dart';
import '../widgetss/cart_empty_state.dart';
import '../widgetss/cart_item_card.dart';
import '../widgetss/cart_checkout_section.dart';
import '../widgets/snakbar.dart'; // استدعاء الكلاس الجديد

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) removeItem;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.removeItem,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Color brandGold = const Color(0xFFCAB273);
  final Color darkText = const Color(0xFF31231C);

  User? currentUser; // 👈 نتحقق من حالة الدخول

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  double get totalPrice {
    double total = 0;
    for (var item in widget.cartItems) {
      String priceString = item["price"].toString().replaceAll("\$", "");
      int quantity = item["quantity"] ?? 1;
      total += (double.tryParse(priceString) ?? 0) * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFF8F6F1),
        automaticallyImplyLeading: false,
        title: Text(
          "My Cart",
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: widget.cartItems.isEmpty
          ? CartEmptyState(brandGold: brandGold, darkText: darkText)
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(18),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return CartItemCard(
                        item: item,
                        brandGold: brandGold,
                        darkText: darkText,
                        onRemove: () => widget.removeItem(item),
                        onUpdate: () => setState(() {}),
                      );
                    },
                  ),
                ),
                CartCheckoutSection(
                  brandGold: brandGold,
                  totalPrice: totalPrice,
                  isLoggedIn: currentUser != null, // 👈 يعتمد على حالة الدخول
                  onCheckout: () {
                    if (currentUser != null) {
                      AppSnackBar.show(
                        context,
                        message: "✅ Order placed successfully",
                        icon: Icons.check_circle,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AuthScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
    );
  }
}
