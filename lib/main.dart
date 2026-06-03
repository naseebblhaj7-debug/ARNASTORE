import 'package:appr/DINAMIC/DashboardPage.dart';

import 'package:appr/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:appr/screens/base_page.dart';
import 'package:appr/screens/start_page.dart';
import 'screens/product_page.dart';
import 'screens/wishlist_page.dart';
import 'screens/cart_page.dart';
import 'screens/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // أول واجهة تفتح
      initialRoute: "start",

      routes: {
        "start": (context) => const StartPage(),
        "base_page": (context) => const HomePage(),

        // 👇 نمرر دوال فاضية بدل null
        "ProductsPage": (context) => ProductsPage(
              favoriteItems: [],
              toggleFavorite: (_) {},
              addToCart: (_) {},
            ),
        "WishlistPage": (context) => WishlistPage(
              favoriteItems: [],
              removeItem: (_) {},
              addToCart: (_) {},
            ),
        "CartPage": (context) => CartPage(
              cartItems: [],
              removeItem: (_) {},
            ),
        "ProfilePage": (context) => const ProfilePage(),
        "DashboardPage": (context) => DashboardPage(),
        "LoginPage": (context) => const AuthScreen(),
      },
    );
  }
}
