import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Center(
        child: Image.asset(
          'images/logo.png',
          height: MediaQuery.of(context).size.height * 0.38,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
