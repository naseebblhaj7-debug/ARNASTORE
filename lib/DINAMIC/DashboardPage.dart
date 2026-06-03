import 'package:appr/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 👈 مهم لتسجيل الخروج
import 'package:appr/DINAMIC/addproduct.dart'; // استدعاء صفحة الإضافة
import 'EditProductPage.dart';

class DashboardPage extends StatelessWidget {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard", style: TextStyle(color: Color.fromARGB(255, 248, 246, 246)),),
        backgroundColor: const Color(0xFFCAB273),
    actions: [
  IconButton(
    icon: const Icon(Icons.home), // 👈 أيقونة البيت
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    },
  ),
  IconButton(
    icon: const Icon(Icons.logout),
    onPressed: () async {
      await FirebaseAuth.instance.signOut(); // 👈 تسجيل خروج
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🚪 Logged out successfully")),
      );
      Navigator.pushReplacementNamed(context, "base_page"); 
      // يرجعك لصفحة البروفايل
    },
  ),
],
),

      body: StreamBuilder<QuerySnapshot>(
        stream: products.orderBy("createdAt", descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var product = docs[index];
              return Card(
                child: ListTile(
                  title: Text(product['title']),
                  subtitle: Text("السعر: ${product['price']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProductPage(product: product),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await products.doc(product.id).delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("🗑️ Product deleted")),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCAB273),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
      ),
    );
  }
}
