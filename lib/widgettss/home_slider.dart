import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_button.dart';

class HomeSlider extends StatefulWidget {
  final List<String> images;
  final PageController pageController;
  final Function(int) onPageChanged;

  const HomeSlider({
    super.key,
    required this.images,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: PageView.builder(
        controller: widget.pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
          widget.onPageChanged(index);
        },
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          final isActive = index == _currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(
              horizontal: isActive ? 8 : 20,
              vertical: isActive ? 0 : 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  /// الصورة بدون أي طبقة سوداء
                  Image.asset(widget.images[index], fit: BoxFit.cover),

                  /// النصوص فقط في أول صورة
                  if (index == 0)
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Family Jewelry\nCollection",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.sectionTitle.copyWith(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.85),
                              shadows: const [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "DESIGNER",
                            style: AppTextStyles.linkText.copyWith(
                              color: Colors.black.withOpacity(0.65),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Jewelry • Bracelets\nNecklaces • Earrings",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 14),
                          CustomButton(
                            text: "Shop Now",
                            onPressed: () {},
                            backgroundColor: AppColors.brandGold,
                            textColor: Colors.white,
                            fontSize: 15,
                            borderRadius: 16,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (index == 1 || index == 2)
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "NEW SHOP",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color: Colors.white.withOpacity(0.4),
                                  blurRadius: 6,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 6),

                          Container(width: 70, height: 2, color: Colors.black),
                        ],
                      ),
                    ),
                  if (index == 1 || index == 2)
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.7, end: 1),
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Opacity(
                              opacity: value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "NEW SHOP",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 10,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  /// خط ذهبي متحرك
                                  TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: 1),
                                    duration: const Duration(
                                      milliseconds: 1200,
                                    ),
                                    curve: Curves.easeOut,
                                    builder: (context, v, child) {
                                      return Container(
                                        width: 70 * v,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            251,
                                            250,
                                            248,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(
                                                0xFFD4AF37,
                                              ).withOpacity(0.5),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
