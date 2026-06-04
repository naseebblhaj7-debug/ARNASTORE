import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/snakbar.dart'; // كلاس AppSnackBar
import '../widgets/custom_button.dart'; // كلاس CustomButton

class AuthButton extends StatelessWidget {
  final bool isLogin;
  final Color gold;
  final Color white;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthButton({
    super.key,
    required this.isLogin,
    required this.gold,
    required this.white,
    required this.emailController,
    required this.passwordController,
  });

  Future<void> _handleAuth(BuildContext context) async {
    try {
      UserCredential userCredential;

      if (isLogin) {
        // تسجيل الدخول
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // جلب صلاحية المستخدم من Firestore
        final doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .get();

        if (!doc.exists) {
          Navigator.of(context).pushReplacementNamed("CartPage");
          return;
        }

        final role = doc.data()?["role"] ?? "user";

        if (role == "admin") {
          Navigator.of(context).pushReplacementNamed("DashboardPage");
        } else {
          Navigator.of(context).pushReplacementNamed("base_page");
        }

        AppSnackBar.show(
          context,
          message: "✅ Login successful: ${userCredential.user?.email}",
          icon: Icons.check_circle,
        );
      } else {
        // إنشاء حساب جديد
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
              "email": userCredential.user?.email,
              "role": "user",
            });

        AppSnackBar.show(
          context,
          message: "✅ Signup successful: ${userCredential.user?.email}",
          icon: Icons.check_circle,
        );

        Navigator.of(context).pushReplacementNamed("CartPage");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        default:
          errorMessage = e.message ?? "An error occurred";
      }
      AppSnackBar.show(
        context,
        message: "❌ $errorMessage",
        icon: Icons.error,
      );
    } catch (e) {
      AppSnackBar.show(
        context,
        message: "❌ Error: $e",
        icon: Icons.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: CustomButton(
        text: isLogin ? "Login" : "Sign Up",   // النص حسب الحالة
        onPressed: () => _handleAuth(context), // الفنكشن اللي ينفذ
        backgroundColor: Colors.transparent,   // الخلفية
        textColor: gold,                       // لون النص
        fontSize: 18,                          // حجم الخط
        fontWeight: FontWeight.bold,           // وزن الخط
        height: 58,                            // ارتفاع الزر
        width: double.infinity,                // عرض الزر
        borderRadius: 15,                      // الحواف
        elevation: 0,                          // بدون ظل
      ),
    );
  }
}
