import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool isFocused;
  final Color brandGold;
  final Function(String) onChanged;
  final VoidCallback onFilterLow;
  final VoidCallback onFilterHigh;
  final VoidCallback onReset;

  const SearchBarWidget({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.isFocused,
    required this.brandGold,
    required this.onChanged,
    required this.onFilterLow,
    required this.onFilterHigh,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 65,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isFocused ? brandGold : Colors.transparent,
                width: 2,
              ),
              boxShadow: isFocused
                  ? [
                      BoxShadow(
                        color: brandGold.withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              cursorColor: brandGold,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: brandGold,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: brandGold.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        PopupMenuButton<String>(
          offset: const Offset(0, 55), // 👈 القائمة تظهر تحت الزر مباشرة
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          elevation: 6,
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: brandGold,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: brandGold.withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.tune_rounded, color: Colors.white),
          ),
          onSelected: (value) {
            if (value == "Low") onFilterLow();
            if (value == "High") onFilterHigh();
            if (value == "Reset") onReset();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: "Low",
              child: Row(
                children: [
                  Icon(Icons.arrow_downward, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Sort: Low Price"),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "High",
              child: Row(
                children: [
                  Icon(Icons.arrow_upward, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Sort: High Price"),
                ],
              ),
            ),
            const PopupMenuItem(
              value: "Reset",
              child: Row(
                children: [
                  Icon(Icons.refresh, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("Reset Filters"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
