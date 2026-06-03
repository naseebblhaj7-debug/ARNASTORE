import 'package:flutter/material.dart';

class AuthTermsText extends StatelessWidget {
  const AuthTermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "by continuing you agree to our terms & privacy policy",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 11),
    );
  }
}
