import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/product_image_slider.dart';
import 'package:appr/widgets/app_bar.dart';
class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final Color goldColor = const Color(0xFFCAB273);
  String selectedSize = "M";
  final List<String> sizes = ["XS", "S", "M", "L", "XL"];

  @override
  Widget build(BuildContext context) {
return Scaffold(
  
  appBar: const CustomAppBar(
    title: "Product Details",
    showBack: true,
  ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            /// SLIDER COMPONENT
            ProductImageSlider(
              images: [
                widget.product["image"],
                widget.product["image2"] ?? widget.product["image"],
              ],
              goldColor: goldColor,
            ),

            /// DETAILS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE + PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product["title"],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        widget.product["price"],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: goldColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: goldColor, size: 20),
                      const Text(
                        "4.9",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "(120 Reviews)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product["description"],
                    style: const TextStyle(
                      color: Colors.grey,
                      height: 1.7,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Available Sizes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: sizes.map((size) {
                      final isSelected = selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => selectedSize = size),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 12),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected ? goldColor : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: goldColor.withOpacity(0.3),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected ? Colors.white : goldColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 35),
                  const Text(
                    "Colors",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      _buildColor(goldColor),
                      _buildColor(const Color(0xffE5D3A1)),
                      _buildColor(const Color(0xff8D6E63)),
                    ],
                  ),

                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: goldColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomButton(
                          text: "Add To Cart",
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior
                                    .floating, // 👈 يخلي الرسالة تطلع فوق
                                margin: const EdgeInsets.all(
                                  12,
                                ), // 👈 مسافة من الأطراف
                                backgroundColor: goldColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // 👈 زوايا ناعمة
                                ),
                                content: Row(
                                  children: const [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                    ), // ✅ أيقونة صح
                                    SizedBox(width: 10),
                                    Text(
                                      "Added to cart successfully",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                duration: const Duration(seconds: 2),
                                elevation: 8, // 👈 ظل احترافي
                              ),
                            );

                            Navigator.pop(context, {
                              ...widget.product,
                              "quantity": 1,
                            });
                          },
                          backgroundColor: goldColor,
                          textColor: Colors.white,
                          fontSize: 18,
                          borderRadius: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColor(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: goldColor.withOpacity(0.3)),
      ),
    );
  }
}
