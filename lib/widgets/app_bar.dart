import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack; // للتحكم في ظهور السهم
  final List<Widget>? actions; // 👈 نضيف باراميتر للأزرار

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBack,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFCAB273),
      elevation: 0,
      actions: actions, // 👈 نعرض الأزرار لو موجودة
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
