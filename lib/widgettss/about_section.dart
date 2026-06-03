import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  final List<String> images = [
    "images/room1.png",
    "images/room2.png",
    "images/room3.png",
    "images/room4.png",
    "images/room5.png",
    "images/room6.png",
  ];

  int currentImage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        currentImage = (currentImage + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Discover the World of ARNA jewelry",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.brandGold,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Home to the finest diamonds and precious stones of unique rarity, unmatched perfection and beauty.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.8),
          ),

          const SizedBox(height: 30),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: Image.asset(
                images[currentImage],
                key: ValueKey(currentImage),
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}