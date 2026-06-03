import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          // لو الحساب مش موجود في Firestore → رجعه للصفحة الرئيسية
          Navigator.of(context).pushReplacementNamed("CartPage");
          return;
        }

        final role = doc.data()?["role"] ?? "user";

        if (role == "admin") {
          Navigator.of(
            context,
          ).pushReplacementNamed("DashboardPage"); // صفحة الأدمن
        } else {
          Navigator.of(context).pushReplacementNamed("base_page"); // صفحة عادية
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login successful: ${userCredential.user?.email}"),
          ),
        );
      } else {
        // إنشاء حساب جديد
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        // إضافة المستخدم الجديد في Firestore مع role = user
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
              "email": userCredential.user?.email,
              "role": "user", // 👈 افتراضي عادي
            });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Signup successful: ${userCredential.user?.email}"),
          ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () => _handleAuth(context),
        child: Text(
          isLogin ? "Login" : "Sign Up",
          style: TextStyle(
            color: gold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
