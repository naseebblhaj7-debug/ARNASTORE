import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_header.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgettss/home_slider.dart';
import '../widgettss/home_slider_dots.dart';
import '../widgettss/service_icon.dart';
import '../widgettss/best_seller_list.dart';
import 'product_page.dart';
import 'wishlist_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import '../widgettss/about_section.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedIndex = 0;

  // 👇 نخزن الفيفورت والسلة
  List<Map<String, dynamic>> favoriteItems = [];
  List<Map<String, dynamic>> cartItems = [];

  final List<String> images = [
    "images/jawaly.png",
    "images/photo1.jpg",
    "images/photo3.jpg",
  ];

  final List<String> bestSellers = [
    "images/p1.jpg",
    "images/p2.jpg",
    "images/p3.jpg",
    "images/p4.jpg",
    "images/p5.jpg",
    "images/p6.jpg",
  ];
  final List<int> prices = [120, 150, 90, 200, 180, 140];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomePage(),
      ProductsPage(
        favoriteItems: favoriteItems,
        toggleFavorite: (product) {
          setState(() {
            if (favoriteItems.contains(product)) {
              favoriteItems.remove(product);
            } else {
              favoriteItems.add(product);
            }
          });
        },
        addToCart: (product) {
          setState(() {
            cartItems.add(product);
          });
        },
      ),
      WishlistPage(
        favoriteItems: favoriteItems,
        removeItem: (product) {
          setState(() {
            favoriteItems.remove(product);
          });
        },
        addToCart: (product) {
          setState(() {
            cartItems.add(product);
          });
        },
      ),
      CartPage(
        cartItems: cartItems,
        removeItem: (item) {
          setState(() {
            cartItems.remove(item);
          });
        },
      ),
      ProfilePage(
        // 👇 نمرر القوائم للـ ProfilePage لو تحتاجها
        // تقدر تعدل ProfilePage باش تستقبلهم وتعرضهم
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              cartItems: cartItems,
              favoriteItems: favoriteItems,
              onAddToCart: (product) {
                setState(() {
                  cartItems.add(product);
                });
              },
              onToggleFavorite: (product) {
                setState(() {
                  if (favoriteItems.contains(product)) {
                    favoriteItems.remove(product);
                  } else {
                    favoriteItems.add(product);
                  }
                });
              },
            ),
            Expanded(child: pages[_selectedIndex]),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeSlider(
            images: images,
            pageController: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
          ),
          const SizedBox(height: 18),
          HomeSliderDots(
            currentPage: _currentPage,
            imagesLength: images.length,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ServiceIcon(
                icon: Icons.flight_takeoff,
                label: "Free Shipping",
                sub: "Order over \$200",
              ),
              ServiceIcon(
                icon: Icons.chat_bubble_outline,
                label: "Support 24/7",
                sub: "Online help",
              ),
              ServiceIcon(
                icon: Icons.verified_user_outlined,
                label: "100% Secure",
                sub: "Safe payment",
              ),
            ],
          ),
          const SizedBox(height: 50),
          AboutSection(),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Best Sellers", style: AppTextStyles.sectionTitle),
                Text("See All", style: AppTextStyles.linkText),
              ],
            ),
          ),
          const SizedBox(height: 15),
          BestSellerList(
            bestSellers: bestSellers,
            prices: prices,
            favoriteItems: favoriteItems,
            cartItems: cartItems,
            onToggleFavorite: (product) {
              setState(() {
                if (favoriteItems.contains(product)) {
                  favoriteItems.remove(product);
                } else {
                  favoriteItems.add(product);
                }
              });
            },
            onAddToCart: (product) {
              setState(() {
                cartItems.add(product);
              });
            },
          ),
        ],
      ),
    );
  }
}
