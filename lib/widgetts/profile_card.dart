import 'package:appr/screens/base_page.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_stat.dart';
import '../DINAMIC/DashboardPage.dart';

class ProfileCard extends StatefulWidget {
  final Color gold;

  const ProfileCard({super.key, required this.gold});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  User? user = FirebaseAuth.instance.currentUser;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  Future<void> _getUserRole() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      setState(() {
        userRole = doc.data()?["role"];
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("🚪 Logged out successfully")));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFCAB273), Color(0xFFB89555)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCAB273),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // صورة المستخدم
          CircleAvatar(
            radius: 38,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : const AssetImage("images/f2.jpg") as ImageProvider,
          ),

          const SizedBox(height: 16),

          // اسم المستخدم أو Welcome
          Text(
            user?.displayName ?? "Welcome",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 8),

          // إيميل المستخدم أو نص افتراضي
          Text(
            user?.email ?? "Login to unlock your luxury experience",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.92),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 22),

          // إحصائيات + أيقونات إضافية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 👇 يظهر أيقونة تسجيل خروج لو المستخدم عادي
              if (user != null && userRole != "admin")
                ProfileStat(icon: Icons.logout, text: "logout", onTap: _logout),

              // 👇 يظهر أيقونة البيت (Dashboard) + تسجيل خروج لو المستخدم Admin
              if (user != null && userRole == "admin") ...[
                ProfileStat(
                  icon: Icons.home,
                  text: "dashboard",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DashboardPage()),
                    );
                  },
                ),
                const _Divider(),
                ProfileStat(icon: Icons.logout, text: "logout", onTap: _logout),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 35,
      color: Colors.white.withOpacity(0.35),
    );
  }
}
