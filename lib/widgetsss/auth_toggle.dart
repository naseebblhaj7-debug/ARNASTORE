import 'package:flutter/material.dart';

class AuthToggle extends StatelessWidget {
  final bool isLogin;
  final Function(bool) onToggle;
  final Color gold;

  const AuthToggle({
    super.key,
    required this.isLogin,
    required this.onToggle,
    required this.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _toggle("login", isLogin, true),
          _toggle("sign up", !isLogin, false),
        ],
      ),
    );
  }

  Widget _toggle(String text, bool active, bool login) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onToggle(login),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active ? gold : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
