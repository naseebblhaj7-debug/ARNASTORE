import 'package:flutter/material.dart';
import '../widgetsss/auth_logo.dart';
import '../widgetsss/auth_toggle.dart';
import '../widgetsss/auth_field.dart';
import '../widgetsss/auth_button.dart';
import '../widgetsss/auth_google_button.dart';
import '../widgetsss/auth_terms_text.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  final Color gold = const Color(0xFFCAB273);
  final Color white = Colors.white;

  // Controllers للإيميل والباسورد
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          /// ================= LOGO =================
          const AuthLogo(),

          /// ================= FORM =================
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.66,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              decoration: BoxDecoration(
                color: gold,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// ================= TOGGLE =================
                    AuthToggle(
                      isLogin: isLogin,
                      onToggle: (value) => setState(() => isLogin = value),
                      gold: gold,
                    ),

                    const SizedBox(height: 28),

                    /// ================= FIELDS =================
                    if (!isLogin)
                      AuthField(
                        icon: Icons.person,
                        hint: "username",
                        controller: usernameController,
                      ),
                    AuthField(
                      icon: Icons.email,
                      hint: "email",
                      controller: emailController,
                    ),
                    AuthField(
                      icon: Icons.lock,
                      hint: "password",
                      obscure: true,
                      controller: passwordController,
                    ),
                    if (!isLogin)
                      AuthField(
                        icon: Icons.lock_outline,
                        hint: "confirm password",
                        obscure: true,
                        controller: confirmPasswordController,
                      ),

                    const SizedBox(height: 18),

                    /// ================= LOGIN/SIGNUP BUTTON =================
                    AuthButton(
                      isLogin: isLogin,
                      gold: gold,
                      white: white,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),

                    const SizedBox(height: 16),

                    /// ================= GOOGLE BUTTON =================
                    const AuthGoogleButton(),

                    const SizedBox(height: 14),

                    /// ================= TEXT (UNDER BUTTONS) =================
                    const AuthTermsText(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
