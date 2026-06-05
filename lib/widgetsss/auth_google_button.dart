import 'package:appr/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/snakbar.dart'; // كلاس AppSnackBar

final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>["email"],
);

Future<UserCredential> signInWithGoogle() async {
  await googleSignIn.signOut(); // يطلع شاشة اختيار الحساب
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  if (googleUser == null) {
    throw Exception("Google sign-in aborted");
  }

  final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class AuthGoogleButton extends StatelessWidget {
  const AuthGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(side: BorderSide.none),
        onPressed: () async {
          try {
            final userCredential = await signInWithGoogle();
            AppSnackBar.show(
              context,
              message: "✅ Login successful: ${userCredential.user?.email}",
              icon: Icons.check_circle,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } catch (e) {
            AppSnackBar.show(
              context,
              message: "❌ Login failed: $e",
              icon: Icons.error,
            );
          }
        },
        icon: Image.network(
          "https://cdn-icons-png.flaticon.com/512/2991/2991148.png",
          width: 22,
          height: 22,
        ),
        label: const Text(
          "Continue with Google",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
