import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.navBarColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandGold.withOpacity(0.6),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, Icons.home_filled, "Home", 0),
          _navItem(
            Icons.grid_view_rounded,
            Icons.grid_view_rounded,
            "Categories",
            1,
          ),
          _navItem(
            Icons.favorite_border_rounded,
            Icons.favorite_rounded,
            "Wishlist",
            2,
          ),
          _navItem(
            Icons.shopping_cart_outlined,
            Icons.shopping_cart,
            "Cart",
            3,
          ),
          _navItem(Icons.person_outline, Icons.person, "Profile", 4),
        ],
      ),
    );
  }

  Widget _navItem(
    IconData normalIcon,
    IconData selectedIcon,
    String label,
    int index,
  ) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 60,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              bottom: isSelected ? 32 : 22,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.brandGold.withOpacity(0.15)
                      : Colors.transparent,
                ),
                child: Icon(
                  isSelected ? selectedIcon : normalIcon,
                  color: isSelected
                      ? AppColors.brandGold
                      : Colors.grey.shade500,
                  size: isSelected ? 26 : 24,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.brandGold
                      : Colors.grey.shade600,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
