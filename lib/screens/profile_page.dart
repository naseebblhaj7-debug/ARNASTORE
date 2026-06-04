import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_screen.dart';

import '../widgetts/profile_card.dart';
import '../widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final Color gold = const Color(0xFFCAB273);
  final Color dark = const Color(0xFF31231C);

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  User? currentUser; // 👈 نتحقق من حالة الدخول

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(_controller);

    currentUser = FirebaseAuth.instance.currentUser; // 👈 نخزن المستخدم الحالي
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loginAnimation() async {
    await _controller.forward();
    await _controller.reverse();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 22),
              ProfileCard(gold: gold),
              const SizedBox(height: 28),
              const SizedBox(height: 35),

              // 👇 زر Login يظهر فقط لو المستخدم مش مسجل دخول
              if (currentUser == null)
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: CustomButton(
                    text: "login / sign up",
                    icon: Icons.login_rounded,
                    width: double.infinity,
                    height: 58,
                    backgroundColor: gold,
                    textColor: Colors.white,
                    borderRadius: 20,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    onPressed: loginAnimation,
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
