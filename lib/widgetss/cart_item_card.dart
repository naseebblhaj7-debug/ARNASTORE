import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Color brandGold;
  final Color darkText;
  final VoidCallback onRemove;
  final VoidCallback onUpdate;

  const CartItemCard({
    super.key,
    required this.item,
    required this.brandGold,
    required this.darkText,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              item["image"],
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          /// TEXT + QUANTITY
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "\$${((double.tryParse(item["price"].toString().replaceAll("\$", "")) ?? 0) * (item["quantity"] ?? 1)).toStringAsFixed(0)}",
                  style: TextStyle(
                    color: brandGold,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    /// MINUS
                    GestureDetector(
                      onTap: () {
                        if ((item["quantity"] ?? 1) > 1) {
                          item["quantity"] = (item["quantity"] ?? 1) - 1;
                          onUpdate();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: brandGold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.remove, size: 18, color: brandGold),
                      ),
                    ),

                    /// QUANTITY
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "${item["quantity"] ?? 1}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: darkText,
                        ),
                      ),
                    ),

                    /// PLUS
                    GestureDetector(
                      onTap: () {
                        item["quantity"] = (item["quantity"] ?? 1) + 1;
                        onUpdate();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: brandGold,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// DELETE
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
