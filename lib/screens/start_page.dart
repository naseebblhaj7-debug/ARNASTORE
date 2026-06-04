import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../theme/app_text_styles.dart';
import '../screens/base_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isSecond = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: SizedBox.expand(
              key: ValueKey(isSecond),
              child: Image.asset(
                isSecond ? "images/poto1.jpg" : "images/poto2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// لمعان خفيف فوق الصورة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.transparent,
                  Colors.black.withOpacity(0.15),
                ],
              ),
            ),
          ),

          /// المحتوى
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                /// النص
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    isSecond
                        ? "Welcome to Butterfly Accessories Store"
                        : "Welcome to Butterfly Accessories\nYour destination for elegance",
                    key: ValueKey(isSecond),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.titleWhite.copyWith(
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                        Shadow(
                          color: const Color.fromARGB(
                            255,
                            151,
                            137,
                            96,
                          ).withOpacity(0.5),
                          blurRadius: 35,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                /// الزر
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isSecond ? 45 : 45),
                    boxShadow: [
                      BoxShadow(
                        color: isSecond
                            ? const Color.fromARGB(
                                255,
                                151,
                                137,
                                96,
                              ).withOpacity(0.6)
                            : Colors.white.withOpacity(0.7),
                        blurRadius: 35,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: isSecond
                            ? const Color.fromARGB(
                                255,
                                151,
                                137,
                                96,
                              ).withOpacity(0.3)
                            : Colors.white.withOpacity(0.3),
                        blurRadius: 60,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: CustomButton(
                    width: 230,
                    height: 58,

                    text: isSecond ? "NEXT" : "START",

                    onPressed: () {
                      if (!isSecond) {
                        setState(() {
                          isSecond = true;
                        });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },

                    backgroundColor: Colors.white,
                    textColor: Color(0xFFCAB273),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,

                    borderRadius: 35,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}