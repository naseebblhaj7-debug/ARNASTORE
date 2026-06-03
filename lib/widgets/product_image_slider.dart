import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> images;
  final Color goldColor;

  const ProductImageSlider({
    super.key,
    required this.images,
    required this.goldColor,
  });

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  late final PageController _controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.80);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 420,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final bool isActive = currentPage == index;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: isActive ? 8 : 35,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: widget.goldColor.withOpacity(
                        isActive ? 0.35 : 0.12,
                      ),
                      blurRadius: isActive ? 28 : 12,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      /// الصورة
                      Image.asset(widget.images[index], fit: BoxFit.cover),

                      /// تأثير خفيف احترافي
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.05),
                              Colors.black.withOpacity(0.08),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 22),

        /// المؤشرات
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
            bool active = currentPage == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: active ? 30 : 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: active ? widget.goldColor : Colors.grey.shade300,
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: widget.goldColor.withOpacity(0.45),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
            );
          }),
        ),
      ],
    );
  }
}
